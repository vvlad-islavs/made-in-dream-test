import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:made_in_dream_test/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:made_in_dream_test/features/features.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> with PaginationMixin<Recipe>, RecipeFilterMixin {
  final _filterLink = LayerLink();
  final _maxTimeTextController = TextEditingController();
  final _searchTextController = TextEditingController();
  final _filterNotifier = ValueNotifier(Filter());

  @override
  void initState() {
    _filterNotifier.addListener(_filterListener);
    super.initState();
  }

  void _filterListener() {
    resetPagination(
      filteredItems: filterRecipes(allItems, _filterNotifier.value),
      idSelector: (item) => item.id,
      initialCount: 5,
    );
    GlobalDialogManager.closeAllOverlays();
  }

  @override
  void dispose() {
    _filterNotifier.removeListener(_filterListener);
    _maxTimeTextController.dispose();
    _searchTextController.dispose();
    _filterNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AbstractRecipesRepository>(
      create: (context) => RecipesRepository(
        localSource: LocalSource(sp: GetIt.I<SharedPreferences>()),
        remoteSource: RemoteSource(dio: GetIt.I<Dio>()),
      ),
      child: RepositoryProvider<AbstractRecipesUsecase>(
        create: (context) => RecipesUsecase(repository: context.read<AbstractRecipesRepository>()),
        child: BlocProvider(
          create: (context) => RecipesBloc(context.read<AbstractRecipesUsecase>())..add(RecipesUpdateAllAndGetItems()),
          child: BlocConsumer<RecipesBloc, RecipesState>(
            listener: (context, state) {
              initPagination(
                allItems: state.recipes,
                filteredItems: filterRecipes(state.recipes, _filterNotifier.value),
                idSelector: (item) => item.id,
                initialCount: 5,
              );

              if (state.isError && state.recipes.isNotEmpty) {
                SnackBarManager.instance.show(
                  context: context,
                  duration: Duration(seconds: 3),
                  content: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: context.appColors.secondary.shade600,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      spacing: 12,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Ошибка получения данных из сети.',
                          style: context.appPoppinsTextTheme.labelMedium!.copyWith(
                            color: context.appColors.googleLogIn.withValues(alpha: 0.8),
                          ),
                        ),
                        RepeatButton(onTap: () => context.read<RecipesBloc>().add(RecipesUpdateAllAndGetItems())),
                      ],
                    ),
                  ),
                );
              }
            },
            builder: (context, state) => Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: context.appColors.backgroundBase,
              body: Align(
                alignment: Alignment.topCenter,
                child: RefreshIndicator(
                  // Полное обновление списка
                  onRefresh: () async => context.read<RecipesBloc>().add(RecipesUpdateAllAndGetItems()),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Stack(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: visibleItemsNotif,
                          builder: (context, items, _) => AppAnimatedSwitcher(
                            activeChildIndex: _activeChildIndex(state.isLoading, state.isError, state.recipes.isEmpty),
                            children: [
                              // Состояние ошибки
                              _buildErrorState(context),
                              // Состояние пустого списка
                              _buildEmptyState(context),
                              ListView.separated(
                                itemCount:
                                    filteredItems.length +
                                    _getItemAdditionalCount(state.isLoading, items.isEmpty, state.isError),
                                padding: EdgeInsets.all(12).copyWith(top: 68),
                                separatorBuilder: (context, index) => Gap(8),
                                itemBuilder: (context, index) {
                                  if (index == items.length && !hasMore) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 24),
                                      child: Text(
                                        'Все рецепты загружены',
                                        textAlign: TextAlign.center,
                                        style: context.appPoppinsTextTheme.bodyMedium!.copyWith(
                                          color: context.appColors.secondary[100],
                                        ),
                                      ),
                                    );
                                  }
                                  final recipe = items.isEmpty || index >= items.length ? null : items[index];
                                  final isLoading = state.isLoading && recipe == null || index > items.length - 1;

                                  return VisibilityDetector(
                                    key: ValueKey('${recipe?.id ?? index}'),
                                    onVisibilityChanged: (VisibilityInfo info) {
                                      // Обновляем список, если виден предпослений элемент
                                      if (info.visibleFraction * 100 > 90 &&
                                          index >= items.length - 1 &&
                                          !state.isLoading) {
                                        nextItems();
                                      }
                                    },
                                    child: ListItem(
                                      recipe: recipe,
                                      isLoading: isLoading,
                                      onTap: () => _showRecipeDetails(recipe!),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        Positioned(top: 0, right: 0, left: 0, child: _buildHead(context, state)),
                        if (state.isLoading && mounted)
                          Positioned(
                            bottom: 24,
                            right: 0,
                            left: 0,
                            child: Padding(padding: EdgeInsets.all(24), child: PulsingDots()),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Stack _buildHead(BuildContext context, RecipesState state) => Stack(
    children: [
      _buildStatus(context, state),
      Positioned(
        top: 12,
        right: 16,
        child: Material(color: AppColors.transparent, child: _buildFilterButton(context)),
      ),
      Positioned(
        top: 12,
        right: 72,
        child: Material(color: AppColors.transparent, child: _buildThemeButton(context)),
      ),
      Positioned(
        top: 12,
        left: 16,
        child: Material(
          color: AppColors.transparent,
          child: AppSearch(
            style: AppSearchStyle.accent,
            isCollapsed: true,
            controller: _searchTextController,
            onChanged: (value) => _filterNotifier.value = _filterNotifier.value.copyWith(searchText: value.trim()),
            onEditingComplete: () =>
                _filterNotifier.value = _filterNotifier.value.copyWith(searchText: _searchTextController.text.trim()),
            onCloseTap: () => _filterNotifier.value = _filterNotifier.value.copyWith(searchText: ''),
          ),
        ),
      ),
    ],
  );

  Column _buildStatus(BuildContext context, RecipesState state) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: context.appColors.backgroundBase),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Text(
                state.isError ? ' Offline' : 'Online',
                textAlign: TextAlign.center,
                style: context.appPoppinsTextTheme.titleLarge,
              ),
            ),
          ),
        ),
        Container(
          height: 16,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentGeometry.topCenter,
              end: AlignmentGeometry.bottomCenter,
              colors: [context.appColors.backgroundBase, context.appColors.backgroundBase.withValues(alpha: 0)],
            ),
          ),
        ),
      ],
    );
  }

  CompositedTransformTarget _buildFilterButton(BuildContext context) => CompositedTransformTarget(
    link: _filterLink,
    child: InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => GlobalDialogManager.showLinkedOverlay(
        context,
        closeOnOverlayTap: false,
        offsetCorrect: Offset(-120, 8),
        link: _filterLink,
        child: ValueListenableBuilder(
          valueListenable: _filterNotifier,
          builder: (context, filter, _) {
            _maxTimeTextController.text = filter.maxMinutes.toString();
            return FilterDialog(
              hasPhoto: filter.hasPhoto,
              controller: _maxTimeTextController,
              onHasPhotoTap: () => _filterNotifier.value = filter.copyWith(hasPhoto: !filter.hasPhoto),
              onMaxTimerClear: () => _filterNotifier.value = filter.copyWith(maxMinutes: 0),
              onMaxTimerEdit: (value) {
                final maxMinutes = int.tryParse(value) ?? 0;

                _maxTimeTextController.text = maxMinutes.toString();
                _filterNotifier.value = filter.copyWith(maxMinutes: maxMinutes);
              },
            );
          },
        ),
      ),
      child: Ink(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: context.appColors.secondary.shade300, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: SvgPicture.asset(
            AppIcons.filterSvg,
            width: 24,
            colorFilter: ColorFilter.mode(context.appColors.secondary.shade700, BlendMode.srcIn),
          ),
        ),
      ),
    ),
  );

  Widget _buildThemeButton(BuildContext context) => InkWell(
    borderRadius: BorderRadius.circular(8),
    onTap: () => AppThemeManager.instance.setInverseThemeStyle(),
    child: Ink(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: context.appColors.secondary.shade300, borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: AnimatedBuilder(
          animation: appThemeManager,
          builder: (context, _) => Icon(
            appThemeManager.style != ThemeStyle.dark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
            color: context.appColors.secondary.shade700,
          ),
        ),
      ),
    ),
  );

  Center _buildErrorState(BuildContext context) => Center(
    child: Column(
      spacing: 36,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Не удалось загрузить\nдоступные рецепты',
          textAlign: TextAlign.center,
          style: context.appPoppinsTextTheme.titleMedium,
        ),
        RepeatButton(onTap: () => context.read<RecipesBloc>().add(RecipesUpdateAllAndGetItems())),
      ],
    ),
  );

  Center _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        spacing: 36,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Нет доступных\nрецептов', textAlign: TextAlign.center, style: context.appPoppinsTextTheme.titleMedium),
          RepeatButton(onTap: () => context.read<RecipesBloc>().add(RecipesUpdateAllAndGetItems())),
        ],
      ),
    );
  }

  void _showRecipeDetails(Recipe recipe) {
    debugPrint('Открыт рецепт: ${recipe.toString()}');
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: context.appColors.transparent,
      builder: (localContext) => RecipeDetailsBottomSheet(recipe: recipe),
    );
  }

  int _activeChildIndex(bool isLoading, bool isError, bool isEmpty) {
    if (isEmpty && !isLoading) {
      if (isError) {
        return 0;
      }

      return 1;
    }
    if (allItems.isNotEmpty && filteredItems.isEmpty) {
      return 1;
    }

    return 2;
  }

  int _getItemAdditionalCount(bool isLoading, bool isRecipesEmpty, bool isError) {
    if (isLoading) {
      if (isRecipesEmpty) {
        return 2;
      }
    }

    if (isError) {
      return 0;
    }

    if (!hasMore) {
      return 1;
    }
    return 0;
  }
}

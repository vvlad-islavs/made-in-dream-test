import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:made_in_dream_test/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:made_in_dream_test/features/features.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:visibility_detector/visibility_detector.dart';

@RoutePage()
class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
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
          create: (context) =>
              RecipesBloc(context.read<AbstractRecipesUsecase>())..add(RecipesUpdateAllAndGetFirstItems(itemsCount: 5)),
          child: BlocConsumer<RecipesBloc, RecipesState>(
            listener: (context, state) {
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
                        _RepeatButton(
                          onTap: () => context.read<RecipesBloc>().add(RecipesUpdateAllAndGetFirstItems(itemsCount: 5)),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
            builder: (context, state) => Scaffold(
              backgroundColor: context.appColors.backgroundBase,
              body: Align(
                alignment: Alignment.topCenter,
                child: RefreshIndicator(
                  // Полное обновление списка
                  onRefresh: () async =>
                      context.read<RecipesBloc>().add(RecipesUpdateAllAndGetFirstItems(itemsCount: 5)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Stack(
                      children: [
                        AppAnimatedSwitcher(
                          activeChildIndex: _activeChildIndex(state.isLoading, state.isError, state.recipes.isEmpty),
                          children: [
                            Center(
                              child: Column(
                                spacing: 36,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Не удалось загурзить\nдоступные рецепты',
                                    textAlign: TextAlign.center,
                                    style: context.appPoppinsTextTheme.titleMedium,
                                  ),
                                  _RepeatButton(
                                    onTap: () => context.read<RecipesBloc>().add(
                                      RecipesUpdateAllAndGetFirstItems(itemsCount: 5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Text(
                                'Нет доступных\nрецептов',
                                textAlign: TextAlign.center,
                                style: context.appPoppinsTextTheme.titleMedium,
                              ),
                            ),
                            ListView.separated(
                              itemCount:
                                  state.recipes.length +
                                  _getItemAdditionalCount(state.isLoading, state.isAllLoaded, state.recipes.isEmpty),
                              padding: EdgeInsets.all(12).copyWith(top: 68),
                              separatorBuilder: (context, index) => Gap(8),
                              itemBuilder: (context, index) {
                                // Данные о рецепте если index не выходит за рамки списка
                                final recipe = state.recipes.isEmpty || index >= state.recipes.length
                                    ? null
                                    : state.recipes[index];

                                // Статус loading, если рецепт пуст и загрузка внутри Bloc или если index выходит за границы
                                final isLoading = state.isLoading && recipe == null || index > state.recipes.length - 1;

                                if (index == state.recipes.length && state.isAllLoaded) {
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

                                return VisibilityDetector(
                                  key: ValueKey('${recipe?.id ?? index}'),
                                  onVisibilityChanged: (VisibilityInfo info) {
                                    // Обновляем список, если виден предпослений элемент
                                    if (info.visibleFraction * 100 > 90 &&
                                        index == state.recipes.length - 1 &&
                                        !state.isAllLoaded &&
                                        !state.isLoading) {
                                      context.read<RecipesBloc>().add(RecipesGetMoreEvent(itemsCount: 5));
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

                        Positioned(
                          top: 25,
                          right: 0,
                          left: 0,
                          child: Text(
                            state.isError ? ' Offline' : 'Online',
                            textAlign: TextAlign.center,
                            style: context.appPoppinsTextTheme.titleLarge,
                          ),
                        ),
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

  // Получаем индекс активного состояния

  // Во время загрузки возвращется список с шиммером, иначе
  // Во ошибки - состояние с кнопкой 'Повторить'
  // Во время пустого списка без ошибки - текст об отсутствии рецептов
  int _activeChildIndex(bool isLoading, bool isError, bool isEmpty) {
    if (isEmpty && !isLoading) {
      if (isError) {
        return 0;
      }

      return 1;
    }

    return 2;
  }

  // Получаем количество элементов в списке

  // При загрузке и пустом списке - 2 доп для шиммера
  // При загрузке и не пустом списке - 0
  // Иначе при загрузке 0
  // При обычно состоянии с не пустым списом - 1 для уведомления
  // Иначе 1 для подгружаемого элемента
  int _getItemAdditionalCount(bool isLoading, bool isAllLoaded, bool isRecipesEmpty) {
    if (isLoading) {
      if (isRecipesEmpty) {
        return 2;
      }

      return 0;
    }

    return 1;
  }
}

class _RepeatButton extends StatelessWidget {
  const _RepeatButton({required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onTap,
        child: Ink(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: context.appColors.secondary.shade400,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text('Повторить', style: context.appPoppinsTextTheme.bodyMedium),
        ),
      ),
    );
  }
}

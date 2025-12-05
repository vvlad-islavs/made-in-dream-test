import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:made_in_dream_test/core/core.dart';
import 'package:made_in_dream_test/features/features.dart';

class RecipeDetailsBottomSheet extends StatefulWidget {
  const RecipeDetailsBottomSheet({super.key, required this.recipe});

  final Recipe recipe;

  @override
  State<RecipeDetailsBottomSheet> createState() => _RecipeDetailsBottomSheetState();
}

class _RecipeDetailsBottomSheetState extends State<RecipeDetailsBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.90,
      minChildSize: 0.8,
      maxChildSize: 0.98,
      builder: (_, scrollController) => Container(
        decoration: BoxDecoration(
          color: context.appColors.backgroundSurface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 5,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2.5)),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          width: 180,
                          height: 180,
                          child: Preview(isLoading: false, imageUrl: widget.recipe.imageUrl),
                        ),
                      ),
                      const Gap(8),
                      if (widget.recipe.title != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: Text(widget.recipe.title!, style: context.appPoppinsTextTheme.labelMedium),
                        ),
                      if (widget.recipe.text != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: Text(
                            widget.recipe.text!,
                            style: context.appPoppinsTextTheme.bodyMedium!.copyWith(
                              color: context.appColors.secondary[25],
                            ),
                          ),
                        ),
                      if (widget.recipe.ingredients != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: Column(
                            spacing: 8,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Ингредиенты:', style: context.appPoppinsTextTheme.labelMedium),
                              Wrap(
                                runSpacing: 2,
                                spacing: 8,
                                children: [
                                  for (final ingredient in widget.recipe.ingredients!) ...[
                                    Row(
                                      spacing: 2,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (ingredient.title != null)
                                          Text('${ingredient.title!}:', style: context.appPoppinsTextTheme.bodyMedium),
                                        if (ingredient.text != null)
                                          Text(
                                            ingredient.text!,
                                            style: context.appPoppinsTextTheme.bodyMedium!.copyWith(
                                              color: context.appColors.secondary[25],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      Column(
                        spacing: 8,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Шаги приготовления:', style: context.appPoppinsTextTheme.labelMedium),
                          Flexible(
                            child: Wrap(
                              runSpacing: 4,
                              spacing: 8,
                              children: [
                                for (final step in widget.recipe.steps) ...[
                                  Container(
                                    margin: EdgeInsets.only(bottom: 8),
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: context.appColors.secondary.shade300),
                                        top: BorderSide(color: context.appColors.secondary.shade300),
                                      ),
                                    ),
                                    child: Row(
                                      spacing: 12,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          spacing: 4,
                                          children: [
                                            if (step.imageUrl1?.isNotEmpty ?? false)
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: SizedBox(
                                                  width: 100,
                                                  height: 100,
                                                  child: Preview(isLoading: false, imageUrl: step.imageUrl1),
                                                ),
                                              ),
                                            if (step.imageUrl2?.isNotEmpty ?? false)
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: SizedBox(
                                                  width: 100,
                                                  height: 100,
                                                  child: Preview(isLoading: false, imageUrl: step.imageUrl2),
                                                ),
                                              ),
                                          ],
                                        ),
                                        if (step.text != null)
                                          Flexible(
                                            child: Text(
                                              step.text!,
                                              style: context.appPoppinsTextTheme.bodyMedium!.copyWith(
                                                color: context.appColors.secondary[25],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Gap(24),
                      if (widget.recipe.energies != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: Column(
                            spacing: 8,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Пищевая ценность:', style: context.appPoppinsTextTheme.labelMedium),
                              Wrap(
                                runSpacing: 2,
                                spacing: 8,
                                children: [
                                  for (final energy in widget.recipe.energies!) ...[
                                    Row(
                                      spacing: 4,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (energy.title != null)
                                          Text('${energy.title!}:', style: context.appPoppinsTextTheme.bodyMedium),
                                        if (energy.text != null)
                                          Text(
                                            energy.text!,
                                            style: context.appPoppinsTextTheme.bodyMedium!.copyWith(
                                              color: context.appColors.secondary[25],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
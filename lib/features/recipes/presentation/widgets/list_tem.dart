import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:made_in_dream_test/core/core.dart';
import 'package:made_in_dream_test/features/features.dart';
import 'package:shimmer/shimmer.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.recipe, this.isLoading = false, required this.onTap});

  final Recipe? recipe;
  final bool isLoading;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: EdgeInsets.all(8).copyWith(top: 16),
        decoration: BoxDecoration(
          color: context.appColors.secondary.shade300.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 128,
                height: 128,
                child: Preview(isLoading: isLoading, imageUrl: recipe?.imageUrl),
              ),
            ),
            const Gap(16),
            Flexible(
              child: AppAnimatedSwitcher(
                duration: AppDelays.defaultDelay,
                activeChildIndex: isLoading ? 0 : 1,
                children: [
                  // Состояние загрузки элемента
                  Shimmer.fromColors(
                    baseColor: AppColors.baseShimmerColor,
                    highlightColor: AppColors.highlightShimmerColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          spacing: 4,
                          children: [
                            Container(height: 20, margin: EdgeInsets.only(right: 128), color: AppColors.white),
                            Container(height: 16, margin: EdgeInsets.only(right: 128), color: AppColors.white),
                          ],
                        ),

                        Container(margin: EdgeInsets.only(top: 24), height: 20, color: AppColors.white),
                      ],
                    ),
                  ),
                  // Состояние загруженного элемента
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        spacing: 4,
                        children: [
                          if (recipe?.title != null)
                            Text(recipe!.title!, style: context.appPoppinsTextTheme.titleLarge),
                          if (recipe?.prepTimeInMinutes != null)
                            Text(
                              'Время приготовления: ${recipe!.prepTimeInMinutes!}',
                              style: context.appPoppinsTextTheme.bodySmall!.copyWith(
                                color: context.appColors.secondary[25],
                              ),
                            ),
                        ],
                      ),
                      if (recipe?.text != null)
                        Container(
                          margin: EdgeInsets.only(top: 24),
                          child: Text(
                            recipe!.text!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.appPoppinsTextTheme.bodyMedium,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

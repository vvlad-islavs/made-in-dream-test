import 'package:flutter/material.dart';
import 'package:made_in_dream_test/core/core.dart';
import 'package:made_in_dream_test/features/features.dart';
import 'package:shimmer/shimmer.dart';

class Preview extends StatelessWidget {
  const Preview({super.key, required this.isLoading, this.imageUrl});

  final bool isLoading;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return AppAnimatedSwitcher(
      duration: AppDelays.defaultDelay,
      activeChildIndex: _getImageActiveIndex(isLoading, imageUrl == null),
      children: [
        Shimmer.fromColors(
          baseColor: AppColors.baseShimmerColor,
          highlightColor: AppColors.highlightShimmerColor,
          child: Container(color: Colors.white),
        ),
        Image.network(
          imageUrl ?? '',
          filterQuality: FilterQuality.high,
          cacheHeight: 512,
          cacheWidth: 512,
          errorBuilder: (context, _, _) => Container(
            color: context.appColors.secondary.shade300,
            alignment: Alignment.center,
            child: const Icon(Icons.broken_image, size: 32, color: Colors.grey),
          ),
          frameBuilder: (context, widget, frame, wasSynchronouslyLoaded) {
            if (frame != null) {
              return widget;
            }

            return Shimmer.fromColors(
              baseColor: AppColors.baseShimmerColor,
              highlightColor: AppColors.highlightShimmerColor,
              child: Container(color: Colors.white),
            );
          },
        ),
        Container(
          decoration: BoxDecoration(color: context.appColors.secondary.shade300),
          child: Center(child: Text('no photo', style: context.appPoppinsTextTheme.labelMedium)),
        ),
      ],
    );
  }

  int _getImageActiveIndex(bool isLoading, bool isNullImage) {
    if (isLoading) {
      return 0;
    }

    if (isNullImage) {
      return 2;
    }

    return 1;
  }
}
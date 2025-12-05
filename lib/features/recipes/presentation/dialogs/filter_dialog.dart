import 'package:flutter/material.dart';
import 'package:made_in_dream_test/core/core.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({
    super.key,
    required this.controller,
    required this.onHasPhotoTap,
    required this.hasPhoto,
    required this.onMaxTimerEdit,
    required this.onMaxTimerClear,
  });

  final bool hasPhoto;
  final TextEditingController controller;
  final Function() onHasPhotoTap;
  final Function(String) onMaxTimerEdit;
  final Function() onMaxTimerClear;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: Container(
        width: 300,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: context.appColors.secondary.shade700, borderRadius: BorderRadius.circular(12)),
        child: Column(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: AppColors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: onHasPhotoTap,
                child: Ink(
                  height: 48,
                  decoration: BoxDecoration(
                    color: context.appColors.secondary.shade500,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Row(
                      spacing: 12,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('C фото', style: context.appPoppinsTextTheme.bodyMedium),
                        Icon(
                          Icons.check,
                          color: hasPhoto ? context.appColors.primary : context.appColors.primary.withValues(alpha: 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: context.appColors.secondary.shade500,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        'Макс. время готовки',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.appPoppinsTextTheme.bodyMedium,
                      ),
                    ),
                    Flexible(
                      child: TextField(
                        style: context.appPoppinsTextTheme.bodyMedium,
                        controller: controller,
                        decoration: InputDecoration(

                          contentPadding: EdgeInsets.all(2),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: context.appColors.secondary.shade400),
                          ),
                        ),
                        onEditingComplete: () => onMaxTimerEdit(controller.text.trim()),
                        onSubmitted: (value) => onMaxTimerEdit(value.trim()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Material(
                        color: AppColors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: onMaxTimerClear,
                          child: Ink(
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: context.appColors.secondary.shade500,
                            ),
                            child: Center(child: Icon(Icons.close, color: context.appColors.secondary.shade300)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

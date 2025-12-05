import 'package:flutter/material.dart';
import 'package:made_in_dream_test/core/core.dart';

class RepeatButton extends StatelessWidget {
  const RepeatButton({super.key, required this.onTap});

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

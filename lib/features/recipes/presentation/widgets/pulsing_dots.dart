import 'package:flutter/material.dart';
import 'package:made_in_dream_test/core/core.dart';

class PulsingDots extends StatefulWidget {
  const PulsingDots({super.key});

  @override
  State<PulsingDots> createState() => _PulsingDotsState();
}

class _PulsingDotsState extends State<PulsingDots> with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  final int dotCount = 3;
  final _canShow = ValueNotifier(false);
  final Duration _delayBetweenAnim = const Duration(milliseconds: 130);
  final Duration _animDuration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(dotCount, (index) => AnimationController(vsync: this, duration: _animDuration));

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.6, end: 1.0).chain(CurveTween(curve: Curves.easeInOut)).animate(controller);
    }).toList();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (int i = 0; i < dotCount; i++) {
        final controller = _controllers[i];
        final phase = i / dotCount; // 0.0, 0.33, 0.66

        controller.value = phase;

        controller.repeat(reverse: true);
      }

      _canShow.value = true;
    });
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _canShow,
      builder: (context, canShow, _) {
        if (!canShow) {
          return SizedBox();
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(dotCount, (index) {
            return AnimatedBuilder(
              animation: _animations[index],
              builder: (context, child) {
                return Transform.scale(scale: _animations[index].value, child: child);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.appColors.contrastComponentsColor.withValues(alpha: 0.7),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

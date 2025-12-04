import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:made_in_dream_test/core/core.dart';

class AppAnimations {
  /// Кастомная анимация перехода AutoRouter.
  static RouteType appRouteAnimation = RouteType.custom(
    duration: AppDelays.fastDelay,
    reverseDuration: AppDelays.fastDelay,
    transitionsBuilder: (context, anim, _, child) => FadeTransition(opacity: anim, child: child),
  );
}

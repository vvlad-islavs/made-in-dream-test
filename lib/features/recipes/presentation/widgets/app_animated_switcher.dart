import 'package:flutter/material.dart';
import 'package:made_in_dream_test/core/core.dart';

class AppAnimatedSwitcher extends StatefulWidget {
  const AppAnimatedSwitcher({
    super.key,
    this.curve = Curves.easeInOut,
    this.duration = AppDelays.defaultDelay,
    required this.children,
    required this.activeChildIndex,
  });

  final Curve curve;
  final Duration duration;
  final int activeChildIndex;
  final List<Widget> children;

  @override
  State<AppAnimatedSwitcher> createState() => _AppAnimatedSwitcherState();
}

class _AppAnimatedSwitcherState extends State<AppAnimatedSwitcher> {
  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
    switchInCurve: widget.curve,
    switchOutCurve: widget.curve,
    duration: widget.duration,
    reverseDuration: widget.duration,
    child: KeyedSubtree(
      key: ValueKey('${widget.children[widget.activeChildIndex]} child key'),
      child: widget.children[widget.activeChildIndex],
    ),
  );
}

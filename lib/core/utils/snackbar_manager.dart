// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';

// Enum для удобного указания позиции
enum SnackBarPosition { top, bottom }

class SnackBarManager {
  // Синглтон для глобального доступа
  SnackBarManager._();

  static final instance = SnackBarManager._();

  OverlayEntry? _overlayEntry;
  Timer? _timer;

  // Ключ для доступа к состоянию виджета-контейнера для анимации закрытия
  final GlobalKey<_SnackBarContainerState> _snackBarKey = GlobalKey<_SnackBarContainerState>();

  // Храним текущий контент для сравнения
  Widget? _currentContent;

  bool _isOperationInProgress = false;

  /// Геттер, который показывает, виден ли снекбар в данный момент.
  bool get isSnackBarVisible => _overlayEntry != null;

  /// Проверяет, совпадает ли новый контент с уже отображаемым.
  /// Сравнивает тип виджета и его ключ. Этого достаточно для большинства случаев.
  /// Для более сложной логики сравнения, виджеты контента должны переопределять оператор `==`.
  bool isContentSame(Widget newContent) {
    if (_currentContent == null) {
      return false;
    }
    return _currentContent.runtimeType == newContent.runtimeType && _currentContent!.key == newContent.key;
  }

  /// Показывает кастомный снекбар.
  ///
  /// [context] - билд-контекст.
  /// [content] - виджет, который будет отображаться внутри снекбара.
  /// [position] - позиция на экране (сверху или снизу).
  /// [margin] - отступы от краев экрана.
  /// [duration] - как долго снекбар будет виден.
  Future<void> show({
    required BuildContext context,
    required Widget content,
    SnackBarPosition position = SnackBarPosition.bottom,
    EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
    Duration duration = const Duration(seconds: 4),
  }) async {
    // Если уже идет операция или показывается тот же контент, выходим.
    if (_isOperationInProgress || isContentSame(content)) {
      return;
    }

    // Блокируем новые операции и оборачиваем в try/finally, чтобы гарантированно разблокировать.
    _isOperationInProgress = true;
    try {
      // Если уже есть другой снекбар, сначала корректно его скрываем.
      if (isSnackBarVisible) {
        await _performHide();
        // Небольшая задержка, чтобы анимация скрытия завершилась визуально.
        await Future.delayed(const Duration(milliseconds: 50));
      }

      _currentContent = content;
      _overlayEntry = _createOverlayEntry(context: context, content: content, position: position, margin: margin);

      Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);

      _timer?.cancel();
      _timer = Timer(duration, hide);
    } finally {
      // освобождаем блокировку в конце.
      _isOperationInProgress = false;
    }
  }

  /// Принудительно скрывает текущий снекбар.
  Future<void> hide() async {
    if (_isOperationInProgress || !isSnackBarVisible) {
      return;
    }

    _isOperationInProgress = true;
    try {
      await _performHide();
    } finally {
      _isOperationInProgress = false;
    }
  }

  Future<void> _performHide() async {
    if (!isSnackBarVisible) {
      return;
    }

    _timer?.cancel();
    // Ждем завершения анимации исчезновения.
    await _snackBarKey.currentState?.dismiss();

    _overlayEntry?.remove();
    _overlayEntry = null;
    _currentContent = null;
  }

  OverlayEntry _createOverlayEntry({
    required BuildContext context,
    required Widget content,
    required SnackBarPosition position,
    required EdgeInsets margin,
  }) => OverlayEntry(
    builder: (context) => Positioned(
      // Динамически устанавливаем top или bottom
      top: position == SnackBarPosition.top ? margin.top : null,
      bottom: position == SnackBarPosition.bottom ? margin.bottom : null,
      left: margin.left,
      right: margin.right,
      child: _SnackBarContainer(key: _snackBarKey, child: content),
    ),
  );
}

/// Внутренний виджет-контейнер, отвечающий за анимацию появления/исчезновения
class _SnackBarContainer extends StatefulWidget {
  final Widget child;

  const _SnackBarContainer({super.key, required this.child});

  @override
  State<_SnackBarContainer> createState() => _SnackBarContainerState();
}

class _SnackBarContainerState extends State<_SnackBarContainer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  /// Метод для запуска анимации исчезновения. Возвращает Future для ожидания.
  Future<void> dismiss() async {
    if (mounted) {
      await _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) => Center(
    child: FadeTransition(
      opacity: _fadeAnimation,
      child: Material(
        // Material нужен для корректного отображения теней и текста
        color: Colors.transparent,
        child: widget.child,
      ),
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

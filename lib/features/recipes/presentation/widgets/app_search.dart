import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:made_in_dream_test/core/core.dart';

enum AppSearchSize {
  sm(height: 36, padding: EdgeInsets.symmetric(vertical: AppSpacings.spacing2)),
  md(height: 40, padding: EdgeInsets.symmetric(vertical: AppSpacings.spacing2_5));

  final double height;
  final EdgeInsets padding;

  const AppSearchSize({required this.height, required this.padding});
}

enum AppSearchStyle { tonal, accent }

enum AppSearchCorners {
  sm(value: AppRadius.radius1_5),
  md(value: AppRadius.radius2),
  lg(value: AppRadius.radius2_5),
  none(value: AppRadius.zero);

  final double value;

  const AppSearchCorners({required this.value});
}

/// Состояние инпута
enum AppSearchState {
  /// Включен
  enabled,

  /// Наведен
  hovered,

  /// В фокусе
  focused,

  /// Отключен
  disabled,
}

class AppSearch extends StatefulWidget {
  const AppSearch({
    super.key,
    required this.controller,
    this.hintText = 'Поиск..',
    this.onChanged,
    this.onTap,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.onEditingComplete,
    this.error = false,
    this.focusNode,
    this.textAlign = TextAlign.left,
    this.maxLines = 1,
    this.maxWidth = 250,
    this.showInfoIndicator = true,
    this.state,
    this.isCollapsed = false,
    this.onCloseTap,
    this.style = AppSearchStyle.accent,
    this.size = AppSearchSize.md,
    this.corners = AppSearchCorners.md,
  });

  final TextEditingController controller;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final VoidCallback? onEditingComplete;
  final bool error;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final int maxLines;
  final double maxWidth;
  final bool showInfoIndicator;
  final AppSearchState? state;
  final AppSearchStyle style;
  final AppSearchSize size;
  final AppSearchCorners corners;
  final bool isCollapsed;
  final Function(String)? onChanged;
  final Function()? onCloseTap;
  final Function()? onTap;

  @override
  State<AppSearch> createState() => _AppSearchState();
}

class _AppSearchState extends State<AppSearch> {
  late final FocusNode _focusNode;
  final _inputKey = GlobalKey();
  final _borderColorNotifier = ValueNotifier<Color>(Colors.transparent);
  final _borderWidthNotifier = ValueNotifier<double>(1.0);
  final _textColorNotifier = ValueNotifier<Color>(Colors.transparent);
  final _hintColorNotifier = ValueNotifier<Color>(Colors.transparent);
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
    _updateBorderNotifiers();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    _focusNode.removeListener(_onFocusChange);
    _borderColorNotifier.dispose();
    _borderWidthNotifier.dispose();
    _textColorNotifier.dispose();
    _hintColorNotifier.dispose();
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _updateBorderNotifiers() {
    _borderColorNotifier.value = _getBorderColor();
    _borderWidthNotifier.value = _getBorderWidth();
    _textColorNotifier.value = _getTextColor();
    _hintColorNotifier.value = _getHintColor();
  }

  void _onFocusChange() {
    if (mounted) {
      setState(() => _isFocused = _focusNode.hasFocus);
      _updateBorderNotifiers();
    }
  }

  void _onTextChanged() {
    if (mounted) {
      setState(() {});
      _updateBorderNotifiers();
    }
  }

  /// Возвращает эффективное состояние
  AppSearchState _getEffectiveState() {
    if (widget.state != null) {
      return widget.state!;
    }
    if (_isFocused) {
      return AppSearchState.focused;
    }
    if (_isHovered) {
      return AppSearchState.hovered;
    }
    return AppSearchState.enabled;
  }

  /// Проверяет, есть ли текст в поле
  bool _hasText() => widget.controller.text.isNotEmpty;

  /// Возвращает цвет фона
  Color _getBackgroundColor() {
    final state = _getEffectiveState();
    if (state == AppSearchState.disabled) {
      return AppColors.colorSemantic.content.neutral.mute;
    }

    if (!_isExpanded && state == AppSearchState.hovered) {
      return widget.style == AppSearchStyle.accent
          ? AppColors.colorSemantic.content.neutral.accent
          : AppColors.colorSemantic.content.neutral.overlay20;
    }
    return widget.style == AppSearchStyle.accent
        ? AppColors.colorSemantic.content.neutral.strong
        : AppColors.colorSemantic.content.neutral.overlay12;
  }

  /// Возвращает цвет границы
  Color _getBorderColor() {
    if (!_isExpanded) {
      return AppColors.colorSemantic.border.neutral.subtle.withValues(alpha: 0);
    }

    final state = _getEffectiveState();
    if (widget.error) {
      return AppColors.colorSemantic.border.negative.accent;
    }
    if (state == AppSearchState.disabled) {
      return AppColors.colorSemantic.border.neutral.mute;
    }
    if (state == AppSearchState.focused && _hasText()) {
      return AppColors.colorSemantic.border.brand.core;
    }
    if (state == AppSearchState.focused) {
      return AppColors.colorSemantic.border.neutral.subtle;
    }
    if (state == AppSearchState.hovered) {
      return AppColors.colorSemantic.border.neutral.accent;
    }
    return AppColors.colorSemantic.border.neutral.subtle;
  }

  /// Возвращает ширину границы
  double _getBorderWidth() {
    final state = _getEffectiveState();
    if (widget.error || state == AppSearchState.focused || state == AppSearchState.hovered) {
      return 1.5;
    }
    return 1.0;
  }

  /// Возвращает цвет текста
  Color _getTextColor() {
    final state = _getEffectiveState();
    if (state == AppSearchState.disabled) {
      return AppColors.colorSemantic.text.neutral.mute;
    }
    if (_hasText()) {
      return AppColors.colorSemantic.text.neutral.accent;
    }
    return AppColors.colorSemantic.text.neutral.subtle;
  }

  /// Возвращает цвет подсказки
  Color _getHintColor() {
    final state = _getEffectiveState();
    if (state == AppSearchState.disabled) {
      return AppColors.colorSemantic.text.neutral.mute;
    }
    return AppColors.colorSemantic.text.neutral.subtle;
  }

  bool get _isExpanded {
    if (!widget.isCollapsed) {
      return true;
    }

    if (_getEffectiveState() == AppSearchState.focused) {
      return true;
    }

    return widget.controller.text.isNotEmpty;
  }

  double _borderRadius() => widget.corners.value;

  Color get _searchIconColor {
    if (_getEffectiveState() == AppSearchState.disabled) {
      return AppColors.colorSemantic.icon.neutral.muted;
    }

    if (_getEffectiveState() == AppSearchState.hovered && !_isExpanded) {
      return AppColors.colorSemantic.icon.brand.strong;
    }

    return AppColors.colorSemantic.icon.neutral.accent;
  }

  void _onCollapsedTap() => setState(() {
    _isFocused = true;
    _focusNode.requestFocus();
  });

  @override
  Widget build(BuildContext context) {
    final state = _getEffectiveState();
    final isFocused = state == AppSearchState.focused;
    final isFocusedWithText = isFocused && _hasText() && !widget.error;
    final isFocusedWithoutText = isFocused && !_hasText() && !widget.error;
    final isHovered = state == AppSearchState.hovered;
    final contentPadding = widget.size.padding;

    // Обновляем notifiers при каждом build для синхронизации
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _updateBorderNotifiers();
      }
    });

    Widget inputContent = Focus(
      onFocusChange: (hasFocus) {
        if (mounted && widget.state == null) {
          setState(() => _isFocused = hasFocus);
        }
      },
      child: MouseRegion(
        onEnter: (_) {
          if (widget.state == null) {
            setState(() => _isHovered = true);
            _updateBorderNotifiers();
          }
        },
        onExit: (_) {
          if (widget.state == null) {
            setState(() => _isHovered = false);
            _updateBorderNotifiers();
          }
        },
        cursor: _getEffectiveState() != AppSearchState.disabled ? SystemMouseCursors.text : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: _isExpanded ? null : _onCollapsedTap,
          child: AnimatedContainer(
            key: _inputKey,
            duration: AppDelays.defaultDelay,
            curve: Curves.easeInOut,
            height: widget.size.height,
            constraints: BoxConstraints(maxWidth: widget.maxWidth),
            decoration: BoxDecoration(
              color: _getBackgroundColor(),
              borderRadius: BorderRadius.circular(_borderRadius()),
            ),
            child: ValueListenableBuilder<Color>(
              valueListenable: _borderColorNotifier,
              builder: (context, borderColor, child) => ValueListenableBuilder<double>(
                valueListenable: _borderWidthNotifier,
                builder: (context, borderWidth, child) => CustomPaint(
                  painter: _InputBorderPainter(
                    borderRadius: BorderRadius.circular(_borderRadius()),
                    borderColor: borderColor,
                    borderWidth: borderWidth,
                  ),
                  child: AnimatedSize(
                    curve: Curves.easeInOut,
                    duration: AppDelays.defaultDelay,
                    reverseDuration: AppDelays.defaultDelay,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: _isExpanded ? MainAxisSize.max : MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(AppSpacings.spacing2).copyWith(
                            left: AppSpacings.spacing2_5,
                            right: _isExpanded ? AppSpacings.spacing2 : AppSpacings.spacing2_5,
                          ),
                          child: SvgPicture.asset(
                            AppIcons.searchSvg,
                            width: 20,
                            colorFilter: ColorFilter.mode(_searchIconColor, BlendMode.srcIn),
                          ),
                        ),
                        if (_isExpanded) ...[
                          Expanded(
                            child: Padding(
                              padding: contentPadding,
                              child: ValueListenableBuilder<Color>(
                                valueListenable: _textColorNotifier,
                                builder: (context, textColor, child) => ValueListenableBuilder<Color>(
                                  valueListenable: _hintColorNotifier,
                                  builder: (context, hintColor, child) => TweenAnimationBuilder<Color?>(
                                    duration: AppDelays.defaultDelay,
                                    curve: Curves.easeInOut,
                                    tween: ColorTween(end: textColor),
                                    builder: (context, animatedTextColor, child) => TweenAnimationBuilder<Color?>(
                                      duration: AppDelays.defaultDelay,
                                      curve: Curves.easeInOut,
                                      tween: ColorTween(end: hintColor),
                                      builder: (context, animatedHintColor, child) => TextField(
                                        controller: widget.controller,
                                        focusNode: _focusNode,
                                        enabled: _getEffectiveState() != AppSearchState.disabled,
                                        inputFormatters: widget.inputFormatters,
                                        keyboardType: widget.keyboardType,
                                        textAlign: widget.textAlign,
                                        maxLines: widget.maxLines,
                                        cursorColor: AppColors.colorSemantic.text.neutral.strong,
                                        cursorHeight: context.appPoppinsTextTheme.labelMedium!.fontSize,
                                        cursorWidth: 1.0,
                                        style: context.appPoppinsTextTheme.labelMedium!.copyWith(
                                          color: animatedTextColor ?? textColor,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: widget.hintText,
                                          hintStyle: context.appPoppinsTextTheme.labelMedium!.copyWith(
                                            color: animatedHintColor ?? hintColor,
                                          ),
                                          border: InputBorder.none,
                                          isDense: true,
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: AppSpacings.spacing1_5,
                                            vertical: 0,
                                          ),
                                        ),
                                        onChanged: (value) => widget.onChanged?.call(value),
                                        onTap: widget.onTap,
                                        onEditingComplete: widget.onEditingComplete,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(AppSpacings.spacing2).copyWith(
                              left: AppSpacings.spacing2_5,
                              right: _isExpanded ? AppSpacings.spacing2 : AppSpacings.spacing2_5,
                            ),
                            child: InkWell(
                              onTap: () {
                                widget.controller.clear();
                                widget.onCloseTap?.call();
                                _focusNode.unfocus();
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Ink(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: context.appColors.secondary.shade300,
                                ),
                                child: Icon(Icons.close),
                              ),
                            ),
                          ),
                        ],
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

    // Добавляем обводку для focused состояния без текста (как у кнопки)
    // Анимируем появление/исчезновение _FocusBorderPainter
    final RenderBox? renderBox = _inputKey.currentContext?.findRenderObject() as RenderBox?;
    final inputWidth = renderBox?.size.width ?? 240;
    final inputHeight = renderBox?.size.height ?? 40;

    // Определяем, какие тени нужно показать
    final showErrorShadow = widget.error && _isExpanded;
    final showHoveredShadow = isHovered && !widget.error;
    final showFocusedWithTextShadow = isFocusedWithText && !widget.error;

    inputContent = Stack(
      clipBehavior: Clip.none,
      children: [
        inputContent,
        // Тень для error состояния
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
          child: AnimatedOpacity(
            duration: AppDelays.defaultDelay,
            curve: Curves.easeInOut,
            opacity: showErrorShadow ? 1.0 : 0.0,
            child: IgnorePointer(
              child: CustomPaint(
                size: Size(inputWidth, inputHeight),
                painter: _ShadowPainter(
                  borderRadius: BorderRadius.circular(_borderRadius() + 3),
                  shadowColor: AppColors.colorSemantic.content.negative.overlay16,
                  spreadRadius: 3,
                ),
              ),
            ),
          ),
        ),
        // Тень для hovered состояния
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
          child: AnimatedOpacity(
            duration: AppDelays.defaultDelay,
            curve: Curves.easeInOut,
            opacity: showHoveredShadow ? 1.0 : 0.0,
            child: IgnorePointer(
              child: CustomPaint(
                size: Size(inputWidth, inputHeight),
                painter: _ShadowPainter(
                  borderRadius: BorderRadius.circular(_borderRadius() + 3),
                  shadowColor: AppColors.colorSemantic.content.neutral.overlay5,
                  spreadRadius: 3,
                ),
              ),
            ),
          ),
        ),
        // Тень для focused состояния с текстом
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
          child: AnimatedOpacity(
            duration: AppDelays.defaultDelay,
            curve: Curves.easeInOut,
            opacity: showFocusedWithTextShadow ? 1.0 : 0.0,
            child: IgnorePointer(
              child: CustomPaint(
                size: Size(inputWidth, inputHeight),
                painter: _ShadowPainter(
                  borderRadius: BorderRadius.circular(_borderRadius() + 3),
                  shadowColor: AppColors.colorSemantic.content.brand.overlay16,
                  spreadRadius: 3,
                ),
              ),
            ),
          ),
        ),
        // Обводка для focused состояния без текста
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
          child: AnimatedOpacity(
            duration: AppDelays.defaultDelay,
            curve: Curves.easeInOut,
            opacity: isFocusedWithoutText ? 1.0 : 0.0,
            child: IgnorePointer(
              child: CustomPaint(
                size: Size(inputWidth, inputHeight),
                painter: _FocusBorderPainter(
                  borderRadius: BorderRadius.circular(_borderRadius()),
                  outerBorderColor: AppColors.colorSemantic.content.brand.core,
                  innerBorderColor: AppColors.colorSemantic.background.core,
                ),
              ),
            ),
          ),
        ),
      ],
    );
    inputContent = AnimatedContainer(
      duration: AppDelays.defaultDelay,
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius() + 2),
        boxShadow: isFocusedWithoutText
            ? const [BoxShadow(offset: Offset(0, 1), blurRadius: 2, spreadRadius: 0, color: Color(0x0D000000))]
            : [],
      ),
      child: inputContent,
    );

    // Добавляем tooltip если он должен быть показан
    return Stack(clipBehavior: Clip.none, children: [inputContent]);
  }
}

/// Painter для рисования равномерной границы инпута
class _InputBorderPainter extends CustomPainter {
  final BorderRadius borderRadius;
  final Color borderColor;
  final double borderWidth;

  _InputBorderPainter({required this.borderRadius, required this.borderColor, required this.borderWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.stroke;

    paint.color = borderColor;
    paint.strokeWidth = borderWidth;
    final rrect = borderRadius
        .resolve(TextDirection.ltr)
        .toRRect(Rect.fromLTWH(borderWidth / 2, borderWidth / 2, size.width - borderWidth, size.height - borderWidth));
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(_InputBorderPainter oldDelegate) =>
      oldDelegate.borderRadius != borderRadius ||
      oldDelegate.borderColor != borderColor ||
      oldDelegate.borderWidth != borderWidth;
}

/// Painter для рисования обводки состояния фокуса
class _FocusBorderPainter extends CustomPainter {
  final BorderRadius borderRadius;
  final Color outerBorderColor;
  final Color innerBorderColor;

  _FocusBorderPainter({required this.borderRadius, required this.outerBorderColor, required this.innerBorderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.stroke;

    paint.color = outerBorderColor;
    paint.strokeWidth = 4;
    final outerRRect = borderRadius
        .resolve(TextDirection.ltr)
        .toRRect(Rect.fromLTWH(-2, -2, size.width + 4, size.height + 4));
    canvas.drawRRect(outerRRect, paint);

    paint.color = innerBorderColor;
    paint.strokeWidth = 2;
    final innerRRect = borderRadius
        .resolve(TextDirection.ltr)
        .toRRect(Rect.fromLTWH(-1, -1, size.width + 2, size.height + 2));
    canvas.drawRRect(innerRRect, paint);
  }

  @override
  bool shouldRepaint(_FocusBorderPainter oldDelegate) =>
      oldDelegate.borderRadius != borderRadius ||
      oldDelegate.outerBorderColor != outerBorderColor ||
      oldDelegate.innerBorderColor != innerBorderColor;
}

/// Painter для рисования теней инпута
class _ShadowPainter extends CustomPainter {
  final BorderRadius borderRadius;
  final Color shadowColor;
  final double spreadRadius;

  _ShadowPainter({required this.borderRadius, required this.shadowColor, required this.spreadRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = shadowColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = spreadRadius;

    final rrect = borderRadius
        .resolve(TextDirection.ltr)
        .toRRect(Rect.fromLTWH(-2, -2, size.width + 4, size.height + 4));
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(_ShadowPainter oldDelegate) =>
      oldDelegate.borderRadius != borderRadius ||
      oldDelegate.shadowColor != shadowColor ||
      oldDelegate.spreadRadius != spreadRadius;
}

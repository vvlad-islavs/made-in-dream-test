
import 'package:flutter/material.dart';
import 'package:made_in_dream_test/core/core.dart';

enum AutoPositionType {
  top(followerAnchor: Alignment.bottomCenter, targetAnchor: Alignment.topCenter),
  bottom(followerAnchor: Alignment.topCenter, targetAnchor: Alignment.bottomCenter);

  final Alignment followerAnchor;
  final Alignment targetAnchor;

  const AutoPositionType({required this.followerAnchor, required this.targetAnchor});
}

/// Автоматические позицинориует вложенный диалог на экране
///
/// Предполагается использование внутри [AppSelectorContentWrapper] с родителем [AppSelector], но возможно и в другом контектсте
class AutoContentPositioned extends StatefulWidget {
  const AutoContentPositioned({
    super.key,
    required this.contentKey,
    required this.child,
    required this.layerLink,
    this.positionType = AutoPositionType.bottom,
    this.headKey,
    this.offsetCorrect = Offset.zero,
    this.bottomMarginCorrect = 0,
    this.maxHeight,
  });

  /// Ключ виджета - основания, желательно [AppSelector].
  ///
  /// Предполагается использование внутри [AppSelectorContentWrapper] с родителем [AppSelector]
  ///
  /// Используется для автоматического позиционирования по границам родителя.
  ///
  /// При null не будет использоваться.
  final GlobalKey? headKey;

  /// Ключ контента, желательно [AppSelectorContentWrapper]
  ///
  /// Предполагается использование внутри [AppSelectorContentWrapper] с родителем [AppSelector]
  final GlobalKey contentKey;

  /// Ссылка на виджет - основание, желатально [AppSelector]
  final LayerLink layerLink;

  /// Максимальная высота [AppSelectorContentWrapper].
  ///
  /// При null используется высота всего контента.
  final double? maxHeight;

  /// Доп. отступ снизу при нехватке места по высоте
  final double bottomMarginCorrect;

  /// Тип автоматического расположения контекста
  final AutoPositionType positionType;

  /// Корректирует итоговое положение виджета.
  final Offset offsetCorrect;

  /// Дочерний виджет.
  final Widget child;

  @override
  State<AutoContentPositioned> createState() => _AutoContentPositionedState();
}

class _AutoContentPositionedState extends State<AutoContentPositioned> {
  final _isInit = ValueNotifier<bool>(true);

  Offset offset = Offset.zero;
  Offset headPos = Offset.zero;

  bool headPosIsSupportFullContentSize = true;

  double _maxContentHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updatePosition());
  }

  void _updatePosition() {
    final contentObj = widget.contentKey.currentContext?.findRenderObject() as RenderBox?;
    final headObj = widget.headKey?.currentContext?.findRenderObject() as RenderBox?;

    if (contentObj != null) {
      final tempHeight = widget.maxHeight ?? contentObj.size.height;
      _maxContentHeight = tempHeight > contentObj.size.height ? contentObj.size.height : tempHeight;

      // Находим размеры и позицию headSelector
      final headSize = headObj?.size ?? Size.zero;

      // Находим размеры contentSelector
      final contentSize = contentObj.size;

      // Рассчитываем позицию contentSelector
      double dy = _calculateDy(headSize, contentSize, contentObj);
      double dx = 0;

      offset = Offset(dx + widget.offsetCorrect.dx, dy - 1 + widget.offsetCorrect.dy);

      _isInit.value = false;
    }
  }

  double _calculateDy(Size headSize, Size contentSize, RenderBox contentObj) {
    double heightFactor = 0;

    final double bottomFreeSpace =
        MediaQuery.of(context).size.height - contentObj.localToGlobal(Offset.zero).dy + headSize.height;

    if (bottomFreeSpace < _maxContentHeight + widget.bottomMarginCorrect &&
        widget.positionType == AutoPositionType.bottom) {
      headPosIsSupportFullContentSize = false;
      // Позиционируем сверху, если места снизу мало
      heightFactor = bottomFreeSpace - _maxContentHeight - headSize.height - widget.bottomMarginCorrect;
    } else {
      headPosIsSupportFullContentSize = true;

      // Снизу
      heightFactor = -headSize.height;
    }

    return heightFactor;
  }

  @override
  void dispose() {
    _isInit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: _isInit,
    builder: (context, isInit, child) => CompositedTransformFollower(
      showWhenUnlinked: false,
      link: widget.layerLink,
      offset: offset,
      followerAnchor: widget.positionType.followerAnchor,
      targetAnchor: widget.positionType.targetAnchor,
      child: AnimatedOpacity(
        duration: AppDelays.fastDelay,
        curve: Curves.easeInOut,
        opacity: isInit ? 0 : 1,
        child: widget.child,
      ),
    ),
  );
}

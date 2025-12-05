import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:made_in_dream_test/core/core.dart';

class GlobalDialogManager {
  static final List<ValueNotifier<OverlayEntry?>> _entries = [];

  /// Ручное добавление [entry].
  static void addOverlayNotif(ValueNotifier<OverlayEntry?> entry) {
    _entries.add(entry);
  }

  /// Показывает диалог при помощи OverlayEntry, привязанный к [link] родителя.
  static Future<bool> showLinkedOverlay(
    BuildContext context, {
    required LayerLink link,
    required Widget child,
    bool closeOnAnyTap = true,
    bool closeOnOverlayTap = true,
    AutoPositionType positionType = AutoPositionType.bottom,

    /// Для контента с неявным размером, который может проявляться только после открытия.
    GlobalKey? contentKey,

    /// Максимальная высота контента.
    double? maxContentHeight,

    /// Кстомный нотифаер оверлея.
    ///
    /// При null используется внутренний
    ValueNotifier<OverlayEntry?>? entryNotif,

    /// Корректирует итоговое положение виджета.
    Offset offsetCorrect = Offset.zero,

    /// Доп. отступ снизу при нехватке места по высоте
    double bottomMarginCorrect = 0,
    Function()? onClose,
  }) async {
    final overlayNotif = entryNotif ?? ValueNotifier<OverlayEntry?>(null);

    final localContentKey = GlobalKey();
    final existingEntry = overlayNotif.value;

    if (existingEntry != null) {
      overlayNotif.value?.remove();
      overlayNotif.value = null;
      await Future.delayed(const Duration(seconds: 3));
      return true;
    }

    final overlay = OverlayEntry(
      builder: (context) => Stack(
        children: [
          if (closeOnAnyTap && !closeOnOverlayTap)
            Positioned.fill(
              child: Listener(
                behavior: HitTestBehavior.translucent,
                onPointerUp: (PointerUpEvent event) async {
                  if (overlayNotif.value == null) return;

                  if (overlayNotif.value?.mounted ?? false) {
                    GlobalDialogManager.removeOverlay(overlayNotif.value);
                    overlayNotif.value = null;
                  }
                },
                child: const SizedBox.expand(),
              ),
            ),
          Center(
            child: AutoContentPositioned(
              contentKey: contentKey ?? localContentKey,
              layerLink: link,
              positionType: positionType,
              offsetCorrect: offsetCorrect,
              maxHeight: maxContentHeight,
              bottomMarginCorrect: bottomMarginCorrect,
              child: contentKey == null ? KeyedSubtree(key: localContentKey, child: child) : child,
            ),
          ),
          if (closeOnAnyTap && closeOnOverlayTap)
            Positioned.fill(
              child: Listener(
                behavior: HitTestBehavior.translucent,
                onPointerUp: (PointerUpEvent event) async {
                  if (overlayNotif.value == null) return;

                  if (overlayNotif.value?.mounted ?? false) {
                    GlobalDialogManager.removeOverlay(overlayNotif.value);
                    overlayNotif.value = null;
                  }
                },
                child: const SizedBox.expand(),
              ),
            ),
        ],
      ),
    );

    overlayNotif.value = overlay;
    Overlay.of(context, rootOverlay: true).insert(overlay);
    GlobalDialogManager.addOverlayNotif(overlayNotif);
    overlayNotif.addListener(() {
      if (overlayNotif.value == null) {
        onClose?.call();
      }
    });

    return true;
  }

  /// Показывает дефолтный диалог.
  static void showDialog(
    BuildContext context, {
    required Widget Function(BuildContext, Animation<double>, Animation<double>) builder,
    Color? barrierColor,
    bool barrierDismissible = true,
  }) {
    showGeneralDialog(
      context: context,
      barrierColor: AppColors.transparent,
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: builder,
    );
  }

  /// Ручное удаление [entry].
  static void removeOverlay(OverlayEntry? entry) {
    final localEntry = _entries.firstWhereOrNull((e) => e.value == entry);

    if (localEntry != null) {
      localEntry.value?.remove();
    }
  }

  static void closeAllOverlays() {
    for (final entry in _entries.toList()) {
      if (entry.value?.mounted ?? false) {
        entry.value?.remove();
        entry.value = null;
      }
    }
    _entries.clear();
  }
}

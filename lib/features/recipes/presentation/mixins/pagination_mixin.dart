import 'package:flutter/material.dart';

import 'package:made_in_dream_test/features/features.dart';

mixin PaginationMixin<T> on State<RecipesScreen> {
  List<T> allItems = [];
  List<T> filteredItems = [];
  final visibleItemsNotif = ValueNotifier([]);
  String? lastElementId;

  String Function(T item)? getId;

  /// Инициализирует паттерн с 0.
  void initPagination({
    required List<T>allItems,
    required List<T> filteredItems,
    required String Function(T item) idSelector,
    int initialCount = 5,
  }) {
    this.allItems = allItems;
    lastElementId = null;
    this.filteredItems = filteredItems;
    getId = idSelector;
    visibleItemsNotif.value = [];

    nextItems(itemsCount: initialCount);
  }

  /// Сбрасывает фильтрованный список и отображаемые элементы.
  void resetPagination({
    required List<T> filteredItems,
    required String Function(T item) idSelector,
    int initialCount = 5,
  }) {
    lastElementId = null;
    this.filteredItems = filteredItems;
    getId = idSelector;
    visibleItemsNotif.value = [];

    nextItems(itemsCount: initialCount);
  }

  void nextItems({int itemsCount = 5}) {
    int startIndex = 0;

    if (lastElementId != null) {
      startIndex = filteredItems.indexWhere((e) => getId!(e) == lastElementId) + 1;

      if (startIndex <= 0) {
        startIndex = 0;
      }
    }

    final next = filteredItems.skip(startIndex).take(itemsCount).toList();

    if (next.isEmpty) return;

    lastElementId = getId!(next.last);

    visibleItemsNotif.value = List.from([...visibleItemsNotif.value, ...next]);
  }

  bool get hasMore =>
      lastElementId == null || filteredItems.indexWhere((e) => getId!(e) == lastElementId) < filteredItems.length - 1;
}

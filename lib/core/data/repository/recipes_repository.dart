import 'dart:math';

import 'package:get_it/get_it.dart';
import 'package:made_in_dream_test/core/core.dart';
import 'package:talker_flutter/talker_flutter.dart';

class RecipesRepository extends AbstractRecipesRepository {
  late final LocalSource _localSource;
  late final RemoteSource _remoteSource;

  RecipesRepository({required LocalSource localSource, required RemoteSource remoteSource})
    : _localSource = localSource,
      _remoteSource = remoteSource;

  @override
  Future<({List<Map<String, dynamic>> items, bool isError})> getAllItems() async {
    List<Map<String, dynamic>>? items;
    bool isError = false;

    try {
      final List<Map<String, dynamic>>? newItems = await _remoteSource.getItems();

      if (newItems?.isNotEmpty ?? false) {
        items = await _localSource.saveItems(items: newItems);
      }
    } catch (e, st) {
      isError = true;
      GetIt.I<Talker>().handle(e, st);
    }

    return (items: items ??= await _localSource.getItems() ?? <Map<String, dynamic>>[], isError: isError);
  }

  @override
  Future<({List<Map<String, dynamic>> items, bool isAllLoaded})> getItemsFromId({
    required String? id,
    int itemsCount = 5,
  }) async {
    List<Map<String, dynamic>>? items = await _localSource.getItems();

    if (items != null) {
      final index = items.indexWhere((e) => e['id'] == id);
      final isAllLoaded = index + itemsCount >= items.length;

      if (index == -1) {
        return (
          items: items.sublist(0, min(itemsCount, items.length)),
          isAllLoaded: isAllLoaded,
        ); // если id не найден возвращаем itemsCount первых элементов
      }
      if (index + 1 >= items.length) {
        return (
          items: <Map<String, dynamic>>[],
          isAllLoaded: isAllLoaded,
        ); // если это последний элемент ничего не возвращаем
      }

      return (
        items: items.sublist(index + 1, min(index + 1 + itemsCount, items.length)),
        isAllLoaded: isAllLoaded,
      ); // Если id найден возвращаем itemsCount элементов после него;
    }

    return (items: <Map<String, dynamic>>[], isAllLoaded: true);
  }
}

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
  Future<List<Map<String, dynamic>>> getAllItems() async {
    List<Map<String, dynamic>>? items;

    try {
      final List<Map<String, dynamic>>? newItems = await _remoteSource.getItems();
      items = await _localSource.saveItems(items: newItems);
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }

    return items ?? [];
  }

  @override
  Future<List<Map<String, dynamic>>> getItemsFromId({required int? id}) async {
    List<Map<String, dynamic>>? items = await _localSource.getItems(id: id);

    if (items != null) {
      final index = items.indexWhere((e) => e['id'] == id);

      if (index == -1) return items; // если id не найден
      if (index + 1 >= items.length) return []; // если это последний элемент

      return items.sublist(index + 1);
    }

    return [];
  }
}

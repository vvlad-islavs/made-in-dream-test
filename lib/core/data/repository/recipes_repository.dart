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
  Future<({List<Map<String, dynamic>> items, bool isError})> tryUpdateAndGetAllItems() async {
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
  Future<List<Map<String, dynamic>>> getAllItems() async => await _localSource.getItems() ?? <Map<String, dynamic>>[];
}

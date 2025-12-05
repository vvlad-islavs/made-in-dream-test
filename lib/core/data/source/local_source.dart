import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:made_in_dream_test/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSource implements Source {
  final SharedPreferences _sp;
  static const _listKey = 'recipes';

  LocalSource({required SharedPreferences sp}) : _sp = sp;

  @override
  Future<List<Map<String, dynamic>>?> getItems() async {
    final items = _sp.getStringList(_listKey);

    return items?.map((element) => jsonDecode(element) as Map<String, dynamic>).toList();
  }

  Future<List<Map<String, dynamic>>?> saveItems({List<Map<String, dynamic>>? items}) async {
    if (items != null) {
      final sp = GetIt.I<SharedPreferences>();

      sp.setStringList(_listKey, items.map((element) => jsonEncode(element)).toList());
    }

    return items;
  }
}

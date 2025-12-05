import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:made_in_dream_test/core/core.dart';

class RemoteSource implements Source {
  late final Dio _dio;

  RemoteSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<Map<String, dynamic>>?> getItems() async {
    final response = await _dio.get('/index.php?route=api/app/getRecipes');

    return ((jsonDecode(response.data))['news'] as List).map((e) => e as Map<String, dynamic>).toList();
  }
}

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:made_in_dream_test/core/core.dart';

class RemoteSource implements Source {
  late final Dio _dio;

  RemoteSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<Map<String, dynamic>>?> getItems({int? id}) async {
    final response = await _dio.get('/index.php?route=api/app/getRecipes');

    log('Status: ${response.statusCode}', name: runtimeType.toString());
    return response.data['news'];
  }
}


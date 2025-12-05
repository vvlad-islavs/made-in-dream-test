import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:made_in_dream_test/app.dart';
import 'package:made_in_dream_test/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AppInitializer {
  static Future<void> initialize() async {
    await _initializeBasics();
    await _initializeApi();
    await _initializeServices();
    await _initializeProviders();
  }

  static Future<void> _initializeBasics() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");

    final sp = await SharedPreferences.getInstance();
    GetIt.I.registerLazySingleton<SharedPreferences>(() => sp);

    AppThemeManager.initialize(brightness: (sp.getBool('isDark') ?? true) ? Brightness.dark : Brightness.light);
  }

  static Future<void> _initializeApi() async {
    final dio = await DioApiClient.create(
      baseUrl: 'https://madeindream.com',
      // Or create .env: BASE_URL=https://madeindream.com
      //Env.baseUrl
    );

    GetIt.I.registerSingleton<Dio>(dio.dio);
  }

  static Future<void> _initializeServices() async {
    final talker = TalkerFlutter.init();
    GetIt.I.registerSingleton(talker);

    FlutterError.onError = (details) {
      // Проверяем, содержит ли ошибка текст, который мы хотим подавить
      final errorMessage = details.exception.toString();
      if (errorMessage.contains("'slot == null': is not true") ||
          errorMessage.contains('BoxConstraints has a negative minimum height')) {
        // Игнорируем эту ошибку
        return;
      }

      // Для всех остальных ошибок используем стандартный обработчик
      GetIt.I<Talker>().handle(details.exception, details.stack);
    };

    Bloc.observer = TalkerBlocObserver(
      talker: talker,
      settings: TalkerBlocLoggerSettings(
        printStateFullData: false,
        printEventFullData: false,
        eventFilter: (bloc, event) {
          return true;
        },
        transitionFilter: (bloc, transition) {
          return true;
        },
      ),
    );
  }

  static Future<void> _initializeProviders() async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: appThemeManager.appColors.secondary.shade400,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: appThemeManager.appColors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    runApp(const MyApp());
  }
}

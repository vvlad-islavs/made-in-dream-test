import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/core.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appThemeManager,
      builder: (context, __) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            systemNavigationBarColor: appThemeManager.appColors.transparent,
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarColor: appThemeManager.appColors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Test App',
            theme: appThemeManager.appTheme,
            routerConfig: appRouter.config(navigatorObservers: () => [RouteObserver()]),
          ),
        );
      },
    );
  }
}

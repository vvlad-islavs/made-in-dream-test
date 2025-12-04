import 'package:made_in_dream_test/app_initializer.dart';

import 'dart:async';

void main() async {
  runZonedGuarded(() async {
    await AppInitializer.initialize();
  }, (error, stack) {});
}

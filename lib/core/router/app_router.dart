import 'package:auto_route/auto_route.dart';
import 'package:made_in_dream_test/features/features.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  AppRouter({super.navigatorKey});

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: RecipesRoute.page, path: '/recipes_screen', initial: true),
      ];
}

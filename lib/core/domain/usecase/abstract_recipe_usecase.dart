import 'package:made_in_dream_test/core/core.dart';

abstract class AbstractRecipesUsecase {

  /// Получает весь список рецептов.
  ///
  /// Пытается обратиться к удаленной БД, если ответ приходит - записывает в локальную, иначе берет из локальной.
  Future<({List<Recipe> recipes, bool isError})> getAllItems();

  /// Получает список рецептов после [id].
  ///
  /// Обращается только к локальной БД.
  Future<({List<Recipe> recipes, bool isAllLoaded})> getMoreRecipes({required List<Recipe>? loadedRecipes,  int itemCount = 5});
}

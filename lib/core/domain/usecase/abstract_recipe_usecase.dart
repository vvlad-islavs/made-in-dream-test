import 'package:made_in_dream_test/core/core.dart';

abstract class AbstractRecipesUsecase {
  /// Получает весь список рецептов.
  ///
  /// Пытается обратиться к удаленной БД, если ответ приходит - записывает в локальную, иначе берет из локальной.
  Future<({List<Recipe> recipes, bool isError})> tryUpdateAndGetAllItems();

  /// Получает весь список рецептов.
  ///
  /// Берет из локальной.
  Future<List<Recipe>> getAllItems();
}

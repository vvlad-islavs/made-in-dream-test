abstract class AbstractRecipesRepository {
  /// Получает весь список рецептов.
  ///
  /// Пытается обратиться к удаленной БД, если ответ приходит - записывает в локальную, иначе берет из локальной.
  Future<({List<Map<String, dynamic>> items, bool isError})> tryUpdateAndGetAllItems();

  /// Получает весь список рецептов.
  ///
  /// Берет из локальной.
  Future<List<Map<String, dynamic>>> getAllItems();
}

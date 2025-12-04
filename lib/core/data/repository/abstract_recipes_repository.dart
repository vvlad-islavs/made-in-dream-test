abstract class AbstractRecipesRepository {

  /// Получает весь список рецептов.
  ///
  /// Пытается обратиться к удаленной БД, если ответ приходит - записывает в локальную, иначе берет из локальной.
  Future<List<Map<String, dynamic>>> getAllItems();

  /// Получает список рецептов после [id].
  ///
  /// Обращается только к локальной БД.
  Future<List<Map<String, dynamic>>> getItemsFromId({required int? id});
}

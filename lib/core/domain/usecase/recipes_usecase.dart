import 'package:made_in_dream_test/core/core.dart';

class RecipesUsecase extends AbstractRecipesUsecase {
  late final AbstractRecipesRepository _repository;

  RecipesUsecase({required AbstractRecipesRepository repository}) : _repository = repository;

  @override
  Future<List<Recipe>> getAllItems() async {
    final allRecipesMap = await _repository.getAllItems();

    return allRecipesMap.map((json) => Recipe.fromJson(json)).toList();
  }

  @override
  Future<List<Recipe>>  getItemsFromId({required int? id}) async {
    final allRecipesMap = await _repository.getItemsFromId(id: id);

    return allRecipesMap.map((json) => Recipe.fromJson(json)).toList();
  }
}

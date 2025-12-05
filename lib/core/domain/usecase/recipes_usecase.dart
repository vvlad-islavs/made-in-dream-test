import 'package:made_in_dream_test/core/core.dart';

class RecipesUsecase extends AbstractRecipesUsecase {
  late final AbstractRecipesRepository _repository;

  RecipesUsecase({required AbstractRecipesRepository repository}) : _repository = repository;

  @override
  Future<({List<Recipe> recipes, bool isError})> tryUpdateAndGetAllItems() async {
    final result = await _repository.tryUpdateAndGetAllItems();

    return (recipes: result.items.map((json) => Recipe.fromJson(json)).toList(), isError: result.isError);
  }

  @override
  Future<List<Recipe>> getAllItems() async =>
      (await _repository.getAllItems()).map((json) => Recipe.fromJson(json)).toList();
}

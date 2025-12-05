import 'package:made_in_dream_test/core/core.dart';

class RecipesUsecase extends AbstractRecipesUsecase {
  late final AbstractRecipesRepository _repository;

  RecipesUsecase({required AbstractRecipesRepository repository}) : _repository = repository;

  @override
  Future<({List<Recipe> recipes, bool isError})> getAllItems() async {
    final result = await _repository.getAllItems();

    return (recipes: result.items.map((json) => Recipe.fromJson(json)).toList(), isError: result.isError);
  }

  @override
  Future<({List<Recipe> recipes, bool isAllLoaded})> getMoreRecipes({
    required List<Recipe>? loadedRecipes,
    int itemCount = 5,
  }) async {
    final result = await _repository.getItemsFromId(id: loadedRecipes?.lastOrNull?.id, itemsCount: itemCount);

    return (
      recipes: <Recipe>[...loadedRecipes ?? [], ...result.items.map((json) => Recipe.fromJson(json))],
      isAllLoaded: result.isAllLoaded,
    );
  }
}

part of 'recipes_bloc.dart';

class RecipesState {
  final List<Recipe> recipes;
  final bool isLoading;
  final bool isError;
  final bool isAllLoaded;

  RecipesState({required this.recipes, this.isLoading = true, this.isError = false, this.isAllLoaded = false});

  RecipesState copyWith({List<Recipe>? recipes, bool? isLoading, bool? isError, bool? isAllLoaded}) => RecipesState(
    recipes: recipes ?? this.recipes,
    isError: isError ?? this.isError,
    isLoading: isLoading ?? false,
    isAllLoaded: isAllLoaded ?? this.isAllLoaded,
  );
}

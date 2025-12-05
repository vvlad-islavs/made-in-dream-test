part of 'recipes_bloc.dart';

class RecipesState {
  final List<Recipe> recipes;
  final bool isLoading;
  final bool isError;

  RecipesState({required this.recipes, this.isLoading = true, this.isError = false});

  RecipesState copyWith({List<Recipe>? recipes, bool? isLoading, bool? isError}) =>
      RecipesState(recipes: recipes ?? this.recipes, isError: isError ?? this.isError, isLoading: isLoading ?? false);
}

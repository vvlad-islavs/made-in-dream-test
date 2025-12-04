part of 'recipes_bloc.dart';

class RecipesState {
  final List<Recipe> recipes;

  RecipesState({required this.recipes});

  RecipesState copyWith({List<Recipe>? recipes}) => RecipesState(recipes: recipes ?? this.recipes);
}

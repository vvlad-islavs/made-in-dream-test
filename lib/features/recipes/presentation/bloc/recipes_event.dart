part of 'recipes_bloc.dart';

sealed class RecipesEvent {}

class RecipesUpdateAllAndGetItems extends RecipesEvent {}

class RecipesGetAllItemsEvent extends RecipesEvent {}

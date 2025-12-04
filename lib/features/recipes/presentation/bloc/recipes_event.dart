part of 'recipes_bloc.dart';

sealed class RecipesEvent {}

class RecipesGetAllEvent extends RecipesEvent {}

class RecipesGetFromLastIdEvent extends RecipesEvent {}

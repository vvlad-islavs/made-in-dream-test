part of 'recipes_bloc.dart';

sealed class RecipesEvent {}

class RecipesUpdateAllAndGetFirstItems extends RecipesEvent {final int itemsCount;

  RecipesUpdateAllAndGetFirstItems({this.itemsCount = 5});}

class RecipesGetMoreEvent extends RecipesEvent {
  final int itemsCount;

  RecipesGetMoreEvent({this.itemsCount = 5});
}

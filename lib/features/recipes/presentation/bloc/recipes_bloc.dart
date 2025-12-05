import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:made_in_dream_test/core/core.dart';
import 'package:made_in_dream_test/core/data/repository/repository.dart';
import 'package:meta/meta.dart';

part 'recipes_event.dart';

part 'recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  final AbstractRecipesUsecase _usecase;

  RecipesBloc(this._usecase) : super(RecipesState(recipes: [])) {
    on<RecipesUpdateAllAndGetFirstItems>((event, emit) async {
      emit(state.copyWith(isLoading: true, recipes: [], isAllLoaded: false));

      final result = await _usecase.getAllItems();

      if (result.isError!= state.isError) {
        emit(state.copyWith(isError: result.isError));
      }

      add(RecipesGetMoreEvent(itemsCount: event.itemsCount));
    });
    on<RecipesGetMoreEvent>((event, emit) async {
      if (state.isAllLoaded) return;

      emit(state.copyWith(isLoading: true));

      final result = await _usecase.getMoreRecipes(loadedRecipes: state.recipes, itemCount: event.itemsCount);
      debugPrint('LastId: ${result.recipes.lastOrNull?.id ?? '-1'}');
      emit(state.copyWith(recipes: result.recipes, isAllLoaded: result.isAllLoaded));
    });
  }
}

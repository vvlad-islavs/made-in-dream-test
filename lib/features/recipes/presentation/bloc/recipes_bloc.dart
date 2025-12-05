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
    on<RecipesUpdateAllAndGetItems>((event, emit) async {
      emit(state.copyWith(isLoading: true, recipes: []));

      final result = await _usecase.tryUpdateAndGetAllItems();

      if (result.isError != state.isError) {
        emit(state.copyWith(isError: result.isError));
      }

      emit(state.copyWith(isLoading: false, recipes: result.recipes));
    });

    on<RecipesGetAllItemsEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, recipes: []));

      final result = await _usecase.getAllItems();

      emit(state.copyWith(isLoading: false, recipes: result));
    });
  }
}

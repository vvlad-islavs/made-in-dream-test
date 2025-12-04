import 'package:bloc/bloc.dart';
import 'package:made_in_dream_test/core/core.dart';
import 'package:made_in_dream_test/core/data/repository/repository.dart';
import 'package:meta/meta.dart';

part 'recipes_event.dart';

part 'recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  final AbstractRecipesUsecase _usecase;

  RecipesBloc(this._usecase) : super(RecipesState(recipes: [])) {
    on<RecipesGetAllEvent>((event, emit) {
      _usecase.getAllItems();
    });
    on<RecipesGetFromLastIdEvent>((event, emit) {
      _usecase.getItemsFromId(id: state.recipes.lastOrNull?.id ?? -1);
    });
  }
}

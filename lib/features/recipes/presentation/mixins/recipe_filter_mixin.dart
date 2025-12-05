import 'package:made_in_dream_test/core/core.dart';

mixin RecipeFilterMixin {
  /// Применяет фильтр к списку рецептов
  List<Recipe> filterRecipes(List<Recipe> recipes, Filter filter) {
    return recipes.where((recipe) {
      // Фильтр по фото
      if (filter.hasPhoto != (recipe.imageUrl != null || recipe.imageUrl!.isNotEmpty)) {
        return false;
      }

      //  Фильтр по времени
      if (filter.maxMinutes > 0 && recipe.prepTimeInMinutes != null) {
        final prepMinutes = _parseMinutes(recipe.prepTimeInMinutes!);
        if (prepMinutes != null && prepMinutes > filter.maxMinutes) {
          return false;
        }
      }

      // Фильтр по поиску в title или ingredients
      final search = filter.searchText.trim().toLowerCase();
      if (search.isNotEmpty) {
        final inTitle = recipe.title?.toLowerCase().contains(search) ?? false;
        final inIngredients =
            recipe.ingredients?.any((ing) => ing.title?.toLowerCase().contains(search) ?? false) ?? false;

        if (!inTitle && !inIngredients) return false;
      }

      return true;
    }).toList();
  }

  /// Парсит число минут из строки prepTimeInMinutes
  int? _parseMinutes(String prepTime) {
    final match = RegExp(r'\d+').firstMatch(prepTime);
    if (match != null) {
      return int.tryParse(match.group(0)!);
    }
    return null;
  }
}

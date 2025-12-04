import 'package:json_annotation/json_annotation.dart';

part 'recipe.g.dart';

@JsonSerializable(explicitToJson: true)
class Recipe {
  final int id;

  final List<RecipeStep> steps;

  @JsonKey(name: 'prep_time', fromJson: _prepTimeFromJson, toJson: _prepTimeToJson)
  final int? prepTimeInMinutes;

  @JsonKey(name: 'energy')
  final List<Energy> energies;

  // Объединяем ingredients_one + ingredients_two
  @JsonKey(
    name: 'ingredients',
    fromJson: _ingredientsFromJson,
    toJson: _ingredientsToJson,
  )
  final List<Ingredient> ingredients;

  @JsonKey(name: 'image')
  final String? imageUrl;

  final String? title;
  final String? text;

  @JsonKey(name: 'date_added')
  final DateTime dateAdded;

  @JsonKey(name: 'link')
  final String linkUrl;

  Recipe({
    required this.id,
    required this.steps,
    required this.prepTimeInMinutes,
    required this.energies,
    required this.ingredients,
    required this.imageUrl,
    required this.title,
    required this.text,
    required this.dateAdded,
    required this.linkUrl,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) =>
      _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);

  static int? _prepTimeFromJson(String? value) {
    if (value == null) return null;

    final parsed = int.tryParse(value.replaceAll(RegExp(r'[^0-9]'), ''));
    return parsed; // "20 минут" -> 20
  }

  static String? _prepTimeToJson(int? value) {
    if (value == null) return null;
    return '$value минут';
  }

  static List<Ingredient> _ingredientsFromJson(Map<String, dynamic> json) {
    final list1 = (json['ingredients_one'] as List<dynamic>? ?? []);
    final list2 = (json['ingredients_two'] as List<dynamic>? ?? []);

    return [
      ...list1.map((e) => Ingredient.fromJson(e)),
      ...list2.map((e) => Ingredient.fromJson(e)),
    ];
  }

  static Map<String, dynamic> _ingredientsToJson(List<Ingredient> list) {
    // При сохранении можем класть в одну группу
    return {
      'ingredients_one': list.map((e) => e.toJson()).toList(),
      'ingredients_two': [],
    };
  }
}

@JsonSerializable()
class RecipeStep {
  final String text;

  // image1 + image2 → imageUrl (берём image1)
  @JsonKey(name: 'image1')
  final String imageUrl;

  RecipeStep({
    required this.text,
    required this.imageUrl,
  });

  factory RecipeStep.fromJson(Map<String, dynamic> json) =>
      _$RecipeStepFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeStepToJson(this);
}

@JsonSerializable()
class Energy {
  final String title;
  final String text;

  Energy({required this.title, required this.text});

  factory Energy.fromJson(Map<String, dynamic> json) =>
      _$EnergyFromJson(json);

  Map<String, dynamic> toJson() => _$EnergyToJson(this);
}

@JsonSerializable()
class Ingredient {
  final String title;
  final String text;

  Ingredient({required this.title, required this.text});

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}

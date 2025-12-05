import 'package:flutter/foundation.dart' show debugPrint;
import 'package:json_annotation/json_annotation.dart';

part 'recipe.g.dart';

@JsonSerializable(explicitToJson: true)
class Recipe {
  final String id;

  final List<RecipeStep> steps;

  @JsonKey(name: 'prep_time', fromJson: _prepTimeFromJson, toJson: _prepTimeToJson)
  final String? prepTimeInMinutes;

  @JsonKey(name: 'energy')
  final List<Energy>? energies;

  // Объединяем ingredients_one + ingredients_two
  @JsonKey(readValue: _ingredientsReadValue, fromJson: _ingredientsFromJson, toJson: _ingredientsToJson)
  final List<Ingredient>? ingredients;

  @JsonKey(name: 'image')
  final String? imageUrl;

  final String? title;
  final String? text;

  @JsonKey(name: 'date_added')
  final DateTime? dateAdded;

  @JsonKey(name: 'link')
  final String? linkUrl;

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

  factory Recipe.fromJson(Map<String, dynamic>? json) => _$RecipeFromJson(json ?? {});

  Map<String, dynamic> toJson() => _$RecipeToJson(this);

  static Object? _ingredientsReadValue(Map json, String key) => json;

  static String? _prepTimeFromJson(String? value) {
    if (value == null) return null;

    return value;
  }

  static String? _prepTimeToJson(String? value) {
    if (value == null) return null;
    return '$value минут';
  }

  static List<Ingredient> _ingredientsFromJson(Map<String, dynamic>? json) {
    debugPrint('IngrJson: $json');
    final list1 = (json?['ingredients_one'] as List<dynamic>? ?? []);
    final list2 = (json?['ingredients_two'] as List<dynamic>? ?? []);

    return <Ingredient>[...list1.map((e) => Ingredient.fromJson(e)), ...list2.map((e) => Ingredient.fromJson(e))];
  }

  static Map<String, dynamic> _ingredientsToJson(List<Ingredient>? list) {
    // При сохранении можем класть в одну группу
    return {'ingredients_one': list?.map((e) => e.toJson()).toList(), 'ingredients_two': []};
  }

  @override
  String toString() {
    return 'Recipe: {title: $title, text: ${text?.substring(0, 20)}, imageUrl: $imageUrl, ingredients: $ingredients, steps: $steps, energies: $energies, dateAdded: $dateAdded, prepTime: $prepTimeInMinutes, link: $linkUrl}';
  }
}

@JsonSerializable()
class RecipeStep {
  final String? text;

  @JsonKey(name: 'image1')
  final String? imageUrl1;
  @JsonKey(name: 'image2')
  final String? imageUrl2;

  RecipeStep({required this.text, this.imageUrl1, this.imageUrl2});

  factory RecipeStep.fromJson(Map<String, dynamic> json) => _$RecipeStepFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeStepToJson(this);
}

@JsonSerializable()
class Energy {
  final String? title;
  final String? text;

  Energy({required this.title, required this.text});

  factory Energy.fromJson(Map<String, dynamic> json) => _$EnergyFromJson(json);

  Map<String, dynamic> toJson() => _$EnergyToJson(this);
}

@JsonSerializable()
class Ingredient {
  final String? title;
  final String? text;

  Ingredient({required this.title, required this.text});

  factory Ingredient.fromJson(Map<String, dynamic> json) => _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}

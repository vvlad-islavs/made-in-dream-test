// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
  id: (json['id'] as num).toInt(),
  steps: (json['steps'] as List<dynamic>)
      .map((e) => RecipeStep.fromJson(e as Map<String, dynamic>))
      .toList(),
  prepTimeInMinutes: Recipe._prepTimeFromJson(json['prep_time'] as String?),
  energies: (json['energy'] as List<dynamic>)
      .map((e) => Energy.fromJson(e as Map<String, dynamic>))
      .toList(),
  ingredients: Recipe._ingredientsFromJson(
    json['ingredients'] as Map<String, dynamic>,
  ),
  imageUrl: json['image'] as String?,
  title: json['title'] as String?,
  text: json['text'] as String?,
  dateAdded: DateTime.parse(json['date_added'] as String),
  linkUrl: json['link'] as String,
);

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
  'id': instance.id,
  'steps': instance.steps.map((e) => e.toJson()).toList(),
  'prep_time': Recipe._prepTimeToJson(instance.prepTimeInMinutes),
  'energy': instance.energies.map((e) => e.toJson()).toList(),
  'ingredients': Recipe._ingredientsToJson(instance.ingredients),
  'image': instance.imageUrl,
  'title': instance.title,
  'text': instance.text,
  'date_added': instance.dateAdded.toIso8601String(),
  'link': instance.linkUrl,
};

RecipeStep _$RecipeStepFromJson(Map<String, dynamic> json) => RecipeStep(
  text: json['text'] as String,
  imageUrl: json['image1'] as String,
);

Map<String, dynamic> _$RecipeStepToJson(RecipeStep instance) =>
    <String, dynamic>{'text': instance.text, 'image1': instance.imageUrl};

Energy _$EnergyFromJson(Map<String, dynamic> json) =>
    Energy(title: json['title'] as String, text: json['text'] as String);

Map<String, dynamic> _$EnergyToJson(Energy instance) => <String, dynamic>{
  'title': instance.title,
  'text': instance.text,
};

Ingredient _$IngredientFromJson(Map<String, dynamic> json) =>
    Ingredient(title: json['title'] as String, text: json['text'] as String);

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{'title': instance.title, 'text': instance.text};

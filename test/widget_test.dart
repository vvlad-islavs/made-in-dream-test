import 'package:flutter_test/flutter_test.dart';
import 'package:made_in_dream_test/core/core.dart';

void main() {
  group('Recipe JSON serialization', () {
    test('Десериализация: объединяет ingredients_one и ingredients_two в один список', () {
      final json = {
        "id": "123",
        "steps": [],
        "prep_time": "45",
        "energy": [
          {"title": "Калории", "text": "320 ккал"},
        ],
        "ingredients_one": [
          {"title": "Мука", "text": "300 г"},
          {"title": "Сахар", "text": "100 г"},
        ],
        "ingredients_two": [
          {"title": "Яйца", "text": "3 шт"},
          {"title": "Масло", "text": "150 г"},
        ],
        "image": "https://example.com/pie.jpg",
        "title": "Пирог",
        "text": "Очень вкусный яблочный пирог...",
        "date_added": "2025-04-15T10:30:00Z",
        "link": "https://example.com/recipe/123",
      };

      final recipe = Recipe.fromJson(json);

      expect(recipe.id, "123");
      expect(recipe.title, "Пирог");
      expect(recipe.prepTimeInMinutes, "45");
      expect(recipe.imageUrl, "https://example.com/pie.jpg");
      expect(recipe.ingredients?.length, 4);

      final titles = recipe.ingredients!.map((i) => i.title).toList();
      expect(titles, ["Мука", "Сахар", "Яйца", "Масло"]);
    });

    test('Сериализация: кладёт все ингредиенты в ingredients_one, ingredients_two остаётся пустым', () {
      final recipe = Recipe(
        id: "999",
        steps: [],
        prepTimeInMinutes: "30",
        energies: [Energy(title: "Белки", text: "12 г")],
        ingredients: [
          Ingredient(title: "Картофель", text: "500 г"),
          Ingredient(title: "Лук", text: "1 шт"),
          Ingredient(title: "Морковь", text: "2 шт"),
        ],
        imageUrl: null,
        title: "Жареная картошка",
        text: "Классика",
        dateAdded: DateTime.parse("2025-01-20T18:00:00Z"),
        linkUrl: null,
      );

      final json = recipe.toJson();

      expect(json['ingredients']['ingredients_one'], hasLength(3));
      expect(json['ingredients']['ingredients_two'], isEmpty);
    });

    test('Если ingredients_one/ingredients_two отсутствуют — ingredients = []', () {
      final json = {
        "id": "empty",
        "steps": [],
        "prep_time": null,
        "energy": null,
        "image": null,
        "title": "Пустой рецепт",
      };

      final recipe = Recipe.fromJson(json);

      expect(recipe.ingredients, []);
      expect(recipe.prepTimeInMinutes, isNull);
    });

    test('Поля с @JsonKey(name: ...) правильно мапятся в обе стороны', () {
      final original = Recipe(
        id: "test1",
        steps: [RecipeStep(text: "Разогреть духовку")],
        prepTimeInMinutes: "25",
        energies: null,
        ingredients: null,
        imageUrl: "https://test.com/img.jpg",
        title: "Тестовый рецепт",
        text: "Описание",
        dateAdded: DateTime.utc(2025, 12, 1),
        linkUrl: "https://example.com/r1",
      );

      final json = original.toJson();
      final restored = Recipe.fromJson(json);

      expect(json['prep_time'], "25");
      expect(json['energy'], isNull);
      expect(json['image'], "https://test.com/img.jpg");
      expect(json['link'], "https://example.com/r1");

      expect(restored.prepTimeInMinutes, "25");
      expect(restored.imageUrl, "https://test.com/img.jpg");
      expect(restored.linkUrl, "https://example.com/r1");
    });
  });
}

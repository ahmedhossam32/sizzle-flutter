import 'ingredient.dart';

class RecipeDetail {
  final String id;
  final String name;
  final String thumbnailUrl;
  final String category;
  final String area;
  final String instructions;
  final String youtubeUrl;
  final List<Ingredient> ingredients;

  RecipeDetail({
    required this.id,
    required this.name,
    required this.thumbnailUrl,
    required this.category,
    required this.area,
    required this.instructions,
    required this.youtubeUrl,
    required this.ingredients,
  });
}

import 'meal_api.dart';
import '../domain/meal.dart';
import '../domain/category.dart';
import '../domain/recipe_detail.dart';

class MealRepository {
  MealRepository(this._api);
  final MealApi _api;

  Future<List<Meal>> getHomeFeed() async {
    final response = await _api.search('chicken');
    return (response.meals ?? []).map((dto) => dto.toDomain()).toList();
  }

  Future<List<Meal>> getMealsByCategory(String category) async {
    final response = await _api.filterByCategory(category);
    return (response.meals ?? []).map((dto) => dto.toDomain()).toList();
  }

  Future<List<Category>> getCategories() async {
    final response = await _api.categories();
    return (response.categories ?? []).map((dto) => dto.toDomain()).toList();
  }

  Future<List<Meal>> searchMeals(String query) async {
    final response = await _api.search(query);
    return (response.meals ?? []).map((dto) => dto.toDomain()).toList();
  }

  Future<RecipeDetail> getRandomMeal() async {
    final response = await _api.random();
    final meals = response.meals ?? [];
    if (meals.isEmpty) {
      throw Exception('No random meal returned');
    }
    return meals.first.toDomain();
  }
}

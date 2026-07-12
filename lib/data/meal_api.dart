import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'meal_dto.dart';
import 'category_dto.dart';

part 'meal_api.g.dart';

@RestApi(baseUrl: 'https://www.themealdb.com/api/json/v1/1')
abstract class MealApi {
  factory MealApi(Dio dio, {String? baseUrl}) = _MealApi;

  @GET('/search.php')
  Future<MealSearchResponse> search(@Query('s') String name);

  @GET('/filter.php')
  Future<MealSearchResponse> filterByCategory(@Query('c') String category);

  @GET('/categories.php')
  Future<CategoryResponse> categories();
}

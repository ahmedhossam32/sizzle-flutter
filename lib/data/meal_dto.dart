import 'package:json_annotation/json_annotation.dart';
import '../domain/meal.dart';

part 'meal_dto.g.dart';

@JsonSerializable()
class MealDto {
  @JsonKey(name: 'idMeal')
  final String idMeal;

  @JsonKey(name: 'strMeal')
  final String strMeal;

  @JsonKey(name: 'strMealThumb')
  final String strMealThumb;

  @JsonKey(name: 'strArea')
  final String? strArea;

  @JsonKey(name: 'strCountry')
  final String? strCountry;

  MealDto({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    this.strArea,
    this.strCountry,
  });

  factory MealDto.fromJson(Map<String, dynamic> json) =>
      _$MealDtoFromJson(json);

  Meal toDomain() => Meal(
    id: idMeal,
    name: strMeal,
    thumbnailUrl: strMealThumb,
    area: strArea ?? strCountry ?? '',
  );
}

@JsonSerializable()
class MealSearchResponse {
  final List<MealDto>? meals;

  MealSearchResponse({this.meals});

  factory MealSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$MealSearchResponseFromJson(json);
}

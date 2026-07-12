// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealDto _$MealDtoFromJson(Map<String, dynamic> json) => MealDto(
  idMeal: json['idMeal'] as String,
  strMeal: json['strMeal'] as String,
  strMealThumb: json['strMealThumb'] as String,
  strArea: json['strArea'] as String?,
  strCountry: json['strCountry'] as String?,
);

Map<String, dynamic> _$MealDtoToJson(MealDto instance) => <String, dynamic>{
  'idMeal': instance.idMeal,
  'strMeal': instance.strMeal,
  'strMealThumb': instance.strMealThumb,
  'strArea': instance.strArea,
  'strCountry': instance.strCountry,
};

MealSearchResponse _$MealSearchResponseFromJson(Map<String, dynamic> json) =>
    MealSearchResponse(
      meals:
          (json['meals'] as List<dynamic>?)
              ?.map((e) => MealDto.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$MealSearchResponseToJson(MealSearchResponse instance) =>
    <String, dynamic>{'meals': instance.meals};

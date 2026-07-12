import 'package:json_annotation/json_annotation.dart';
import '../domain/category.dart';

part 'category_dto.g.dart';

@JsonSerializable()
class CategoryDto {
  @JsonKey(name: 'strCategory')
  final String strCategory;

  @JsonKey(name: 'strCategoryThumb')
  final String strCategoryThumb;

  CategoryDto({required this.strCategory, required this.strCategoryThumb});

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  Category toDomain() =>
      Category(name: strCategory, thumbnailUrl: strCategoryThumb);
}

@JsonSerializable()
class CategoryResponse {
  final List<CategoryDto>? categories;

  CategoryResponse({this.categories});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);
}

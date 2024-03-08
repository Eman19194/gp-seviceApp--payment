import 'CategoryResponse.dart';

class CategoriesResponse {
  final List<CategoryResponse> data;

  CategoriesResponse({required this.data});

  factory CategoriesResponse.fromJson(List<dynamic> json) {
    List<CategoryResponse> categories = json.map((e) => CategoryResponse.fromJson(e)).toList();
    return CategoriesResponse(data: categories);
  }
}
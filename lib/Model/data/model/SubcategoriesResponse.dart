import 'SubcategoryResponse.dart';

class SubcategoriesResponse {
  final List<SubcategoryResponse> data;

  SubcategoriesResponse({required this.data});

  factory SubcategoriesResponse.fromJson(List<dynamic> json) {
    List<SubcategoryResponse> categories = json.map((e) => SubcategoryResponse.fromJson(e)).toList();
    return SubcategoriesResponse(data: categories);
  }
}
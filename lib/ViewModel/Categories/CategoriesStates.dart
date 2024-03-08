import '../../Model/data/model/CategoriesResponse.dart';
import '../../Model/data/model/CategoryResponse.dart';

abstract class CategoriesStates{}

class CategoriesInitialState extends CategoriesStates{}

class CategoriesLoadingState extends CategoriesStates{
  String? loadingMessage ;
  CategoriesLoadingState({required this.loadingMessage});
}

class CategoriesErrorState extends CategoriesStates{
  String? errorMessage ;
  CategoriesErrorState({this.errorMessage});
}

class CategoriesSuccessState extends CategoriesStates{
  /// response
  CategoriesResponse response ;
  CategoriesSuccessState({required this.response});
}
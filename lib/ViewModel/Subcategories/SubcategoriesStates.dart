import '../../Model/data/model/SubcategoriesResponse.dart';

abstract class SubcategoriesStates{}

class SubcategoriesInitialState extends SubcategoriesStates{}

class SubcategoriesLoadingState extends SubcategoriesStates{
  String? loadingMessage ;
  SubcategoriesLoadingState({required this.loadingMessage});
}

class SubcategoriesErrorState extends SubcategoriesStates{
  String? errorMessage ;
  SubcategoriesErrorState({this.errorMessage});
}

class SubcategoriesSuccessState extends SubcategoriesStates{
  /// response
  SubcategoriesResponse response ;
  SubcategoriesSuccessState({required this.response});
}
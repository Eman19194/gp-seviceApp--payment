import '../../Model/data/model/CategoryResponse.dart';

abstract class SpacificCategoryStates{}

class SpacificCategoryInitialState extends SpacificCategoryStates{}

class SpacificCategoryLoadingState extends SpacificCategoryStates{
  String? loadingMessage ;
  SpacificCategoryLoadingState({required this.loadingMessage});
}

class SpacificCategoryErrorState extends SpacificCategoryStates{
  String? errorMessage ;
  SpacificCategoryErrorState({this.errorMessage});
}

class SpacificCategorySuccessState extends SpacificCategoryStates{
  /// response
  CategoryResponse response ;
  SpacificCategorySuccessState({required this.response});
}
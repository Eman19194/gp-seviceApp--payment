import '../../Model/data/model/SubcategoryResponse.dart';

abstract class SpecificSubcategoryStates{}

class SpecificSubcategoryInitialState extends SpecificSubcategoryStates{}

class SpecificSubcategoryLoadingState extends SpecificSubcategoryStates{
  String? loadingMessage ;
  SpecificSubcategoryLoadingState({required this.loadingMessage});
}

class SpecificSubcategoryErrorState extends SpecificSubcategoryStates{
  String? errorMessage ;
  SpecificSubcategoryErrorState({this.errorMessage});
}

class SpecificSubcategorySuccessState extends SpecificSubcategoryStates{
  /// response
  SubcategoryResponse response ;
  SpecificSubcategorySuccessState({required this.response});
}
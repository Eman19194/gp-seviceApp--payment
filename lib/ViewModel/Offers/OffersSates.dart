

import 'package:gp/Model/data/model/OffersResponse.dart';

abstract class OffersStates{}

class OffersInitialState extends OffersStates{}

class OffersLoadingState extends OffersStates{
  String? loadingMessage ;
  OffersLoadingState({required this.loadingMessage});
}

class OffersErrorState extends OffersStates{
  String? errorMessage ;
  OffersErrorState({this.errorMessage});
}

class OffersSuccessState extends OffersStates{
  /// response
  List<OffersResponse> response ;
  OffersSuccessState({required this.response});
}
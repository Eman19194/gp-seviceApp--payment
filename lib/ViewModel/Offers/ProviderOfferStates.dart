
import 'package:gp/Model/data/model/ProvideOfferResponse.dart';

abstract class ProviderOfferStates{}

class ProviderOfferInitialState extends ProviderOfferStates{}

class ProviderOfferLoadingState extends ProviderOfferStates{
  String? loadingMessage ;
  ProviderOfferLoadingState({required this.loadingMessage});
}

class ProviderOfferErrorState extends ProviderOfferStates{
  String? errorMessage ;
  ProviderOfferErrorState({this.errorMessage});
}

class ProviderOfferSuccessState extends ProviderOfferStates{
  /// response
  ProvideOfferResponse  response ;
  ProviderOfferSuccessState({required this.response});
}
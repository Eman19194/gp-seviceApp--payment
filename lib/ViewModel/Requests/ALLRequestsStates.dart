import 'package:gp/Model/data/model/CustomerRequestsresponse.dart';

abstract class RequestsStates{}

class RequestsInitialState extends RequestsStates{}

class RequestsLoadingState extends RequestsStates{
  String? loadingMessage ;
  RequestsLoadingState({required this.loadingMessage});
}

class RequestsErrorState extends RequestsStates{
  String? errorMessage ;
  RequestsErrorState({this.errorMessage});
}

class RequestsSuccessState extends RequestsStates{
  /// response
  List<CustomerRequestsresponse> response ;
  RequestsSuccessState({required this.response});
}
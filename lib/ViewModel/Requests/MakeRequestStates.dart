import 'package:gp/Model/data/model/CustomerRequestsresponse.dart';
import 'package:gp/Model/data/model/MakeReqResponse.dart';

abstract class MakeRequestStates{}

class MakeRequestInitialState extends MakeRequestStates{}

class MakeRequestLoadingState extends MakeRequestStates{
  String? loadingMessage ;
  MakeRequestLoadingState({required this.loadingMessage});
}

class MakeRequestErrorState extends MakeRequestStates{
  String? errorMessage ;
  MakeRequestErrorState({this.errorMessage});
}

class MakeRequestSuccessState extends MakeRequestStates{
  /// response
  MakeReqResponse response ;
  MakeRequestSuccessState({required this.response});
}
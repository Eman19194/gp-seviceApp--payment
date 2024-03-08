import 'package:gp/Model/data/model/LoginResponse.dart';


abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class LoginLoadingState extends LoginStates{
  String? loadingMessage ;
  LoginLoadingState({required this.loadingMessage});
}

class LoginErrorState extends LoginStates{
  String? errorMessage ;
  LoginErrorState({this.errorMessage});
}

class LoginSuccessState extends LoginStates{
  /// response
  LoginResponse  response ;
  LoginSuccessState({required this.response});
}
import 'package:gp/Model/data/model/ForgetPasswordResponse.dart';

abstract class ForgetPasswordStates{}

class ForgetPasswordInitialState extends ForgetPasswordStates{}

class ForgetPasswordLoadingState extends ForgetPasswordStates{
  String? loadingMessage ;
  ForgetPasswordLoadingState({required this.loadingMessage});
}

class ForgetPasswordErrorState extends ForgetPasswordStates{
  String? errorMessage ;
  ForgetPasswordErrorState({this.errorMessage});
}

class ForgetPasswordSuccessState extends ForgetPasswordStates{
  /// response
  ForgetPasswordResponse  response ;
  ForgetPasswordSuccessState({required this.response});
}
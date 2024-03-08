import '../../Model/data/model/ResetPassResponse.dart';

abstract class ResetPasswordStates{}

class ResetPasswordInitialState extends ResetPasswordStates{}

class ResetPasswordLoadingState extends ResetPasswordStates{
  String? loadingMessage ;
  ResetPasswordLoadingState({required this.loadingMessage});
}

class ResetPasswordErrorState extends ResetPasswordStates{
  String? errorMessage ;
  ResetPasswordErrorState({this.errorMessage});
}

class ResetPasswordSuccessState extends ResetPasswordStates{
  /// response
  ResetPassResponse  response ;
  ResetPasswordSuccessState({required this.response});
}
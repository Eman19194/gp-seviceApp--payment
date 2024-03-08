import 'package:gp/Model/data/model/SignUpResponse.dart';

abstract class SignUpState{
}
class SignUpInitialState extends SignUpState{}
class SignUpLoadingState extends SignUpState{
  String? loadingMsg;
  SignUpLoadingState({required this.loadingMsg});
}
class SignUpErrorState extends SignUpState{
  String? errorMsg;
  SignUpErrorState({required this.errorMsg});
}
class SignUpSuccessState extends SignUpState{
  SignUpResponse response;
  SignUpSuccessState({required this.response});
}
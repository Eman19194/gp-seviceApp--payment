// ForgetPassVM ViewModel
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Model/data/model/ForgetPasswordResponse.dart';
import 'package:gp/Repository/repository/repository/auth_repository_contract.dart';
import 'ForgetPassStates.dart';

class ForgetPassVM extends Cubit<ForgetPasswordStates> {
  final AuthRepoContract repoContract;
  var emailController = TextEditingController();
  var codeController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String responseCode = "";
  int currentStep = 1;

  ForgetPassVM(this.repoContract) : super(ForgetPasswordInitialState());

  Future<void> forgetPassword() async {
    try {
      emit(ForgetPasswordLoadingState(loadingMessage: "Loading..."));
      var response =
      await repoContract.forgetPassword(emailController.text);

      if (response.statusMsg == "success") {
        emit(ForgetPasswordSuccessState(response: response));
        print('forgetPass Successful.>>>>>>>> ${response.message}');
        if (response.code != null) {
          responseCode = response.code!;
          print("Responsecode>>>>>${responseCode}");
        }
        // Clear text fields
        emailController.clear();
      } else {
        emit(ForgetPasswordErrorState(
            errorMessage: response.message ?? 'Unknown error'));
        print('Failed to forgetPass.>>>>>>>>>>>> ${response.message}');
      }
    } catch (error) {
      emit(ForgetPasswordErrorState(errorMessage: error.toString()));
      print('Failed to forgetPass. Error: $error');
    }
  }

  String? validateEmail(String value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  bool validateCode(String value) {
    if (value == null || value.isEmpty) {
      return false;
    } else if (responseCode.isEmpty) {
      return false;
    } else if (value != responseCode) {
      return false;
    }
    return true;
  }
}

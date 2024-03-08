import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gp/Repository/repository/repository/auth_repository_contract.dart';
import 'package:gp/ViewModel/ForgetPassword/ResetPassStates.dart';

class ResetPassVM extends Cubit<ResetPasswordStates> {
  ResetPassVM(this.repoContract) : super(ResetPasswordInitialState());
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  static String? customerID;
  bool isObscure = true;
  AuthRepoContract repoContract;
  Future<void> resetPassword() async {
    if (formKey.currentState!.validate()) {
      // Perform sign-up logic here
      try{
        emit(ResetPasswordLoadingState(loadingMessage: "Loading..."));
        var response=await repoContract.resetPassword(emailController.text, passwordController.text,
            confirmPasswordController.text);

        if(response.statusMsg=='fail'){
          emit(ResetPasswordErrorState(errorMessage: response.message));
        }else {
          emit(ResetPasswordSuccessState(response: response));
        }
      }catch(e){
        emit(ResetPasswordErrorState(errorMessage: e.toString()));

      }

    }
  }

  String? validateEmail(String value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }


  String? validatePassword(String value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password should be at least 8 characters long';
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password should contain at least one uppercase letter';
    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password should contain at least one number';
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password should contain at least one special character';
    }

    return null;
  }

  String? validateConfirmPassword(String value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }




}

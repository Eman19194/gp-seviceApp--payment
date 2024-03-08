import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gp/Repository/repository/repository/auth_repository_contract.dart';


import 'SignUp_State.dart';
class SignUpViewMode extends Cubit<SignUpState> {
  SignUpViewMode(this.repoContract) : super(SignUpInitialState());
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  static String? customerID;
   bool isObscure = true;
  AuthRepoContract repoContract;
  Future<void> signUp() async {
    if (formKey.currentState!.validate()) {
      // Perform sign-up logic here
      try{
        emit(SignUpLoadingState(loadingMsg: "Loading...."));
        var response=await repoContract.signUp(emailController.text, passwordController.text,
            confirmPasswordController.text);
        customerID=response.userId;
        if(response.statusMsg=='fail'){
          emit(SignUpErrorState(errorMsg: response.message));
        }else {
          emit(SignUpSuccessState(response: response));
        }
      }catch(e){
        emit(SignUpErrorState(errorMsg: e.toString()));

      }

    }
  }
  Future<void> signUpProvider() async {
    if (formKey.currentState!.validate()) {
      // Perform sign-up logic here
      try{
        emit(SignUpLoadingState(loadingMsg: "Loading...."));
        var response=await repoContract.signUpProvider(emailController.text, passwordController.text,
            confirmPasswordController.text);
        customerID=response.userId;
        if(response.statusMsg=='fail'){
          emit(SignUpErrorState(errorMsg: response.message));
        }else {
          emit(SignUpSuccessState(response: response));
        }
      }catch(e){
        emit(SignUpErrorState(errorMsg: e.toString()));

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

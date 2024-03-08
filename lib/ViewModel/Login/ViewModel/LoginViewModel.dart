import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Repository/repository/repository/auth_repository_contract.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'LoginState.dart';

class LoginScreenViewModel extends Cubit<LoginStates> {
  final AuthRepoContract repoContract;

  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isObscure = true;

  LoginScreenViewModel(this.repoContract) : super(LoginInitialState());

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      try {
        emit(LoginLoadingState(loadingMessage: "Loading..."));
        var response = await repoContract.login(
            emailController.text, passwordController.text);

        if (response.statusMsg == "success") {
          emit(LoginSuccessState(response: response));
          print('Login Successful.>>>>>>>> ${response.message}');
        } else {
          emit(LoginErrorState(
              errorMessage: response.message ?? 'Unknown error'));
          print('Failed to login.>>>>>>>>>>>> ${response.message}');
        }
      } catch (error) {
        emit(LoginErrorState(errorMessage: error.toString()));
        print('Failed to login. Error: $error');
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
    }
    return null;
  }


  String? extractNameIdentifierFromToken(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    String? nameIdentifier = decodedToken["http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"];
    return nameIdentifier;
  }
}

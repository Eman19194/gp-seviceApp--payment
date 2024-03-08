// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:gp/Repository/repository/repository/auth_repository_contract.dart';
// import 'package:gp/View/createProfile.dart';
// import 'package:gp/ViewModel/CreateProfileViewModel/createProfileState.dart';
//
// class CreateProfileScreenViewModel extends Cubit<CreateProfileStates> {
//   CreateProfileScreenViewModel(this.repoContract) : super(CreateProfileInitialState());
//   final formKey = GlobalKey<FormState>();
//
//   TextEditingController _fNameController = TextEditingController();
//   TextEditingController _lNameController = TextEditingController();
//   TextEditingController _cityController = TextEditingController();
//   String _selectedCountry = 'Country1';
//   String _selectedGender = 'Male';
//   DateTime selectedDate = DateTime.now();
//   TextEditingController _addressController = TextEditingController();
//   TextEditingController _birthDateController = TextEditingController();
//   TextEditingController _disabilityController = TextEditingController();
//   TextEditingController _emergencyContactController = TextEditingController();
//
//   List<String> countries = ['Country1', 'Country2', 'Country3'];
//   List<String> genders = ['Male', 'Female', 'Other'];
//
//   AuthRepoContract repoContract;
  // Future<void> CreateProfile() async {
  //   if (formKey.currentState!.validate()) {
  //     // Perform sign-up logic here
  //     try{
  //       emit(CreateProfileLoadingState(loadingMsg: "Loading...."));
  //       var response=await repoContract.createProfile(fname, lname, city, country, address, gender, birthdate, disability, emergencyContact);
  //       if(response.statusMsg=='fail'){
  //         emit(CreateProfileErrorState(errorMsg: response.message));
  //       }else {
  //         emit(CreateProfileSuccessState(response: response));
  //       }
  //     }catch(e){
  //       emit(CreateProfileErrorState(errorMsg: e.toString()));
  //
  //     }
  //
  //   }
  // }
  //
  // String? validateEmail(String value) {
  //   if (value == null || value.isEmpty) {
  //     return 'This field is required';
  //   } else if (!RegExp(
  //       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
  //       .hasMatch(value)) {
  //     return 'Invalid email address';
  //   }
  //   return null;
  // }
  //
  //
  // String? validatePassword(String value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter your password';
  //   } else if (value.length < 6 ) {
  //     return 'Password should be greater than 6';
  //   }
  //   return null;
  // }
  // String? validateConfirmPassword(String value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please confirm your password';
  //   } else if (value != passwordController.text) {
  //     return 'Passwords do not match';
  //   }
  //   return null;
  // }
//
//
//
//
// }

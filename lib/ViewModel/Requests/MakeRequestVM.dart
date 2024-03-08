import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gp/Model/data/model/CategoryResponse.dart';
import 'package:gp/Model/data/model/MakeReqResponse.dart';
import 'package:gp/Repository/repository/repository/auth_repository_contract.dart';
import 'package:gp/View/MakeRequest.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'MakeRequestStates.dart';


class MakeRequestViewModel extends Cubit<MakeRequestStates> {
   AuthRepoContract repoContract;
   GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController discriptionController = TextEditingController();
  String selectedLocation = "";
   MakeRequestViewModel(this.repoContract) : super(MakeRequestInitialState());
  //  List<CategoryResponse>? Categories;
  //  List<String> categoryNames = [];
  //  _extractCategoryNames(List<CategoryResponse>? categories) {
  //    categoryNames =categories?.map((category) => category.name ?? '').toList() ?? [];
  //  }
  Future<MakeReqResponse> makeRequest(
      String customerID,
      int catID,
      Uint8List imageBytes,
      ) async {
    if (formKey.currentState!.validate()) {
      try {
        emit(MakeRequestLoadingState(loadingMessage: "Loading..."));
        final response = await repoContract.makeRequest(customerID, catID, 0, discriptionController.text,selectedLocation, imageBytes);
        if (response.statusMsg == "success") {
          emit(MakeRequestSuccessState(response: response));
          return response;
          print('Make request Successful: ${response.message}');
        } else {
          emit(MakeRequestErrorState(
            errorMessage: response.message ?? 'Unknown error',
          ));
          return MakeReqResponse(serviceId: 0,statusMsg: "",message: "");

        }
      } catch (error) {
        emit(MakeRequestErrorState(errorMessage: error.toString()));
        print('Failed to request. Error: $error');
        return MakeReqResponse(serviceId: 0,statusMsg: "",message: "");
      }
    } else {
      emit(MakeRequestErrorState(
        errorMessage: 'Validation failed. Please check your input.',
      ));
      return MakeReqResponse(serviceId: 0,statusMsg: "",message: "");
    }
  }
   // void setCategories(List<CategoryResponse> categories){
   //  this.Categories=categories;
   // }

  int convertCatId(TextEditingController catId) {
    final inputText = catId.text.trim();
    final parsedInt = int.tryParse(inputText);
    return parsedInt ?? 0;
  }
   // int? categoryIdFromName(String categoryName) {
   //   for (var category in Categories ?? []) {
   //     if (category.name == categoryName) {
   //       return category.id;
   //     }
   //   }
   //   return null; // Return null if category with given name is not found
   // }
}

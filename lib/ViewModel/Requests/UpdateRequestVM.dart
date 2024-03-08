import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Model/data/model/UpdateServiceResponse.dart';
import 'package:gp/Repository/repository/repository/auth_repository_contract.dart';

abstract class UpdateRequestStates{}

class UpdateRequestInitialState extends UpdateRequestStates{}

class UpdateRequestLoadingState extends UpdateRequestStates{
  String? loadingMessage ;
  UpdateRequestLoadingState({required this.loadingMessage});
}

class UpdateRequestErrorState extends UpdateRequestStates{
  String? errorMessage ;
  UpdateRequestErrorState({this.errorMessage});
}

class UpdateRequestSuccessState extends UpdateRequestStates {
  /// response
  UpdateServiceResponse response;

  UpdateRequestSuccessState({required this.response});
}

mixin UpdateRequestResponse {
}
class UpdateRequestVM extends Cubit<UpdateRequestStates> {
  final AuthRepoContract repoContract;


  UpdateRequestVM(this.repoContract) : super(UpdateRequestInitialState());

  Future<void> updateRequest(int serviceID,String description,String location, Uint8List imageBytes) async {
  try {
      emit(UpdateRequestLoadingState(loadingMessage: "Loading..."));
      var response = await repoContract.updateRequest(serviceID, description, location, imageBytes);

      if (response.statusMsg == "success") {
        emit(UpdateRequestSuccessState(response: response));
        print('UpdateService Successful.>>>>>>>> ${response.message}');
      } else {
        emit(UpdateRequestErrorState(
            errorMessage: response.message ?? 'Unknown error'));
        print('Failed to UpdateService.>>>>>>>>>>>> ${response.message}');
      }
    } catch (error) {
      emit(UpdateRequestErrorState(errorMessage: error.toString()));
      print('Failed to UpdateService. Error: $error');
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Model/data/model/DeleteServiceResponse.dart';

import '../../Repository/repository/repository/auth_repository_contract.dart';

abstract class DeleteServiceStates{}

class DeleteServiceInitialState extends DeleteServiceStates{}

class DeleteServiceLoadingState extends DeleteServiceStates{
  String? loadingMessage ;
  DeleteServiceLoadingState({required this.loadingMessage});
}

class DeleteServiceErrorState extends DeleteServiceStates{
  String? errorMessage ;
  DeleteServiceErrorState({this.errorMessage});
}

class DeleteServiceSuccessState extends DeleteServiceStates {
  /// response
  DeleteServiceResponse response;

  DeleteServiceSuccessState({required this.response});
}
class DeleteServiceVM extends Cubit<DeleteServiceStates> {
  final AuthRepoContract repoContract;


  DeleteServiceVM(this.repoContract) : super(DeleteServiceInitialState());

  Future<void> deleteService(int serviceID) async {
    try {
      emit(DeleteServiceLoadingState(loadingMessage: "Loading..."));
      var response = await repoContract.deleteService(serviceID);

      if (response.statusMsg == "success") {
        emit(DeleteServiceSuccessState(response: response));
        print('DeleteService.>>>>>>>> ${response.message}');
      } else {
        emit(DeleteServiceErrorState(
            errorMessage: response.message ?? 'Unknown error'));
        print('Failed to login.>>>>>>>>>>>> ${response.message}');
      }
    } catch (error) {
      emit(DeleteServiceErrorState(errorMessage: error.toString()));
      print('Failed to login. Error: $error');
    }
  }
  Future<void> cancelOffer(int offerID) async {
    try {
      emit(DeleteServiceLoadingState(loadingMessage: "Loading..."));
      var response = await repoContract.cancelOffer(offerID);

      if (response.statusMsg == "success") {
        emit(DeleteServiceSuccessState(response: response));
        print('cancelOffer.>>>>>>>> ${response.message}');
      } else {
        emit(DeleteServiceErrorState(
            errorMessage: response.message ?? 'Unknown error'));
        print('Failed to cancelOffer.>>>>>>>>>>>> ${response.message}');
      }
    } catch (error) {
      emit(DeleteServiceErrorState(errorMessage: error.toString()));
      print('Failed tocancelOffer. Error: $error');
    }
  }
}


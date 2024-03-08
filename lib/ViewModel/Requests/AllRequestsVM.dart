import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Model/data/model/CustomerRequestsresponse.dart';
import 'package:gp/Repository/repository/repository/auth_repository_contract.dart';

import 'ALLRequestsStates.dart';

class AllRequestsVM extends Cubit<RequestsStates> {
  final AuthRepoContract repoContract;

  AllRequestsVM(this.repoContract) : super(RequestsInitialState());

 Future<List<CustomerRequestsresponse>> getAllRequests(String customerID)async {
    try {
      emit(RequestsLoadingState(loadingMessage: "Loading..."));
      var response = await repoContract.getAllRequests(customerID);

      if (response.isEmpty) {
        emit(RequestsErrorState(errorMessage: 'Empty response')); // Handle empty response
        print('There is no requests.');
      } else {
        emit(RequestsSuccessState(response: response));
        print('requests fetched successfully: $response');
      }
      return response;
    } catch (e) {
      emit(RequestsErrorState(errorMessage: 'Error fetching requests: $e')); // Handle error
      throw Exception('There is no requests: $e'); // Throw the error so it can be caught elsewhere
    }
  }
  Future<List<CustomerRequestsresponse>> AllRequestsProvider()async {
    try {
      emit(RequestsLoadingState(loadingMessage: "Loading..."));
      var response = await repoContract.getAllRequestsProvider();

      if (response.isEmpty) {
        emit(RequestsErrorState(errorMessage: 'Empty response')); // Handle empty response
        print('There is no requestsProvider.');
      } else {
        emit(RequestsSuccessState(response: response));
        print('requests Provider fetched successfully: $response');
      }
      return response;
    } catch (e) {
      emit(RequestsErrorState(errorMessage: 'Error fetching requestsProvider: $e')); // Handle error
      throw Exception('There is no requestsProvider: $e'); // Throw the error so it can be caught elsewhere
    }
  }
}

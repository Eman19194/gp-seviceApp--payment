
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Model/data/model/OffersResponse.dart';
import 'package:gp/Repository/repository/repository/auth_repository_contract.dart';

import 'OffersSates.dart';

class OffersVM extends Cubit<OffersStates> {
  final AuthRepoContract repoContract;

  OffersVM(this.repoContract) : super(OffersInitialState());

  Future<List<OffersResponse>> getOffers(int serviceID)async {
    try {
      emit(OffersLoadingState(loadingMessage: "Loading..."));
      var response = await repoContract.getOffers(serviceID);

      if (response.isEmpty) {
        emit(OffersErrorState(errorMessage: 'Empty response')); // Handle empty response
        print('There is no Offers.');
      } else {
        emit(OffersSuccessState(response: response));
        print('Offers fetched successfully: $response');
      }
      return response;
    } catch (e) {
      emit(OffersErrorState(errorMessage: 'Error fetching Offers: $e')); // Handle error
      throw Exception('There is no Offers: $e'); // Throw the error so it can be caught elsewhere
    }
  }
  Future<List<OffersResponse>> getProviderOffers(String providerID)async {
    try {
      emit(OffersLoadingState(loadingMessage: "Loading..."));
      var response = await repoContract.getProviderOffers(providerID);

      if (response.isEmpty) {
        emit(OffersErrorState(errorMessage: 'Empty response')); // Handle empty response
        print('There is no ProviderOffers.');
      } else {
        emit(OffersSuccessState(response: response));
        print('ProviderOffers fetched successfully: $response');
      }
      return response;
    } catch (e) {
      emit(OffersErrorState(errorMessage: 'Error fetching ProviderOffers: $e')); // Handle error
      throw Exception('There is no ProviderOffers: $e'); // Throw the error so it can be caught elsewhere
    }
  }
}

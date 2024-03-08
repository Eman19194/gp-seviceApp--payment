

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Repository/repository/repository/auth_repository_contract.dart';
import 'package:gp/ViewModel/Offers/ProviderOfferStates.dart';

import '../../Model/data/model/ProvideOfferResponse.dart';

class ProviderOfferVM extends Cubit<ProviderOfferStates> {
  final AuthRepoContract repoContract;



  ProviderOfferVM(this.repoContract) : super(ProviderOfferInitialState());

  Future<void> providerOffer(String providerID,int serviceID,int fees,int timeID,String duration) async {

      try {
        emit(ProviderOfferLoadingState(loadingMessage: "Loading..."));
        var response = await repoContract.providerOffer(providerID, serviceID, fees, timeID, duration);

        if (response.statusMsg == "success") {
          emit(ProviderOfferSuccessState(response: response));
          print('ProviderOffer Successful.>>>>>>>> ${response.message}');
        } else {
          emit(ProviderOfferErrorState(
              errorMessage: response.message ?? 'Unknown error'));
          print('Failed toProviderOffer.>>>>>>>>>>>> ${response.message}');
        }
      } catch (error) {
        emit(ProviderOfferErrorState(errorMessage: error.toString()));
        print('Failed to ProviderOffer. Error: $error');
      }
    }
  Future<void> updateOffer(int offerID,int fees,int timeID,String duration) async {
    try {
      emit(ProviderOfferLoadingState(loadingMessage: "Loading..."));
      var response = await repoContract.updateOffer(offerID, fees, timeID, duration);

      if (response.statusMsg == "success") {
        emit(ProviderOfferSuccessState(response: response));
        print('ProviderOffer Successful.>>>>>>>> ${response.message}');
      } else {
        emit(ProviderOfferErrorState(
            errorMessage: response.message ?? 'Unknown error'));
        print('Failed toProviderOffer.>>>>>>>>>>>> ${response.message}');

      }

    } catch (error) {
      emit(ProviderOfferErrorState(errorMessage: error.toString()));
      print('Failed to ProviderOffer. Error: $error');
    }

  }


}


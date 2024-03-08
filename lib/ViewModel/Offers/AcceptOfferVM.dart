import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Model/data/model/AcceptOfferResponse.dart';
import 'package:gp/Repository/repository/repository/auth_repository_contract.dart';

abstract class AcceptOfferStates{}

class AcceptOfferInitialState extends AcceptOfferStates{}

class AcceptOfferLoadingState extends AcceptOfferStates{
  String? loadingMessage ;
  AcceptOfferLoadingState({required this.loadingMessage});
}

class AcceptOfferErrorState extends AcceptOfferStates{
  String? errorMessage ;
  AcceptOfferErrorState({this.errorMessage});
}

class AcceptOfferSuccessState extends AcceptOfferStates {
  /// response
  AcceptOfferResponse response;

  AcceptOfferSuccessState({required this.response});
}
class AcceptOfferVM extends Cubit<AcceptOfferStates> {
  final AuthRepoContract repoContract;


  AcceptOfferVM(this.repoContract) : super(AcceptOfferInitialState());

  Future<void> acceptOffer(int offerID) async {
    try {
      emit(AcceptOfferLoadingState(loadingMessage: "Loading..."));
      var response = await repoContract.acceptOffer(offerID);

      if (response.statusMsg == "success") {
        emit(AcceptOfferSuccessState(response: response));
        print('AcceptOffer Successful.>>>>>>>> ${response.message}');
      } else {
        emit(AcceptOfferErrorState(
            errorMessage: response.message ?? 'Unknown error'));
        print('Failed to AcceptOffer.>>>>>>>>>>>> ${response.message}');
      }
    } catch (error) {
      emit(AcceptOfferErrorState(errorMessage: error.toString()));
      print('Failed to AcceptOffer. Error: $error');
    }
  }
}



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Model/data/model/DeclineOfferResponse.dart';
import 'package:gp/Repository/repository/repository/auth_repository_contract.dart';

abstract class DeclineOfferStates{}

class DeclineOfferInitialState extends DeclineOfferStates{}

class DeclineOfferLoadingState extends DeclineOfferStates{
  String? loadingMessage ;
  DeclineOfferLoadingState({required this.loadingMessage});
}

class DeclineOfferErrorState extends DeclineOfferStates{
  String? errorMessage ;
  DeclineOfferErrorState({this.errorMessage});
}

class DeclineOfferSuccessState extends DeclineOfferStates {
  /// response
 DeclineOfferResponse response;

  DeclineOfferSuccessState({required this.response});
}
class DeclineOfferVM extends Cubit<DeclineOfferStates> {
  final AuthRepoContract repoContract;


  DeclineOfferVM(this.repoContract) : super(DeclineOfferInitialState());

  Future<void> declineOffer(int offerID) async {
    try {
      emit(DeclineOfferLoadingState(loadingMessage: "Loading..."));
      var response = await repoContract.declineOffer(offerID);

      if (response.statusMsg == "success") {
        emit(DeclineOfferSuccessState(response: response));
        print('DeclineOffer Successful.>>>>>>>> ${response.message}');
      } else {
        emit(DeclineOfferErrorState(
            errorMessage: response.message ?? 'Unknown error'));
        print('Failed to DeclineOffer.>>>>>>>>>>>> ${response.message}');
      }
    } catch (error) {
      emit(DeclineOfferErrorState(errorMessage: error.toString()));
      print('Failed to DeclineOffer. Error: $error');
    }
  }
}


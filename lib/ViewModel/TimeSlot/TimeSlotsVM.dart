import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Repository/repository/repository/auth_repository_contract.dart';

import '../../Model/data/model/AllTimeSlotsResponse.dart';
import 'TimeSlotsStates.dart';

class TimeSlotsVM extends Cubit<TimeSlotsStates> {
  TimeSlotsVM(this.repoContract) : super(TimeSlotsInitialState());
  AuthRepoContract repoContract;
  Future<List<AllTimeSlotsResponse>> getAllTimeSlots(int serviceID)async {
    try {
      emit(TimeSlotsLoadingState(loadingMsg: "Loading....."));
      var response = await repoContract.getAllTimeSlots(serviceID);

      if (response.isEmpty) {
        emit(TimeSlotsErrorState(errorMsg:" there is no Time Slots ")); // Handle empty response
        print('There is no Time Slots.');
      } else {
        emit(TimeSlotsSuccessState(response: response));
        print('Time Slots fetched successfully: $response');
      }
      return response;
    } catch (e) {
      emit(TimeSlotsErrorState(errorMsg:  'Error fetching TimeSlots: $e')); // Handle error
      throw Exception('There is no TimeSlots: $e'); // Throw the error so it can be caught elsewhere
    }
  }
}
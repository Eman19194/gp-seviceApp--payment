import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Model/data/model/TimeSlot.dart';
import '../../Repository/repository/repository/auth_repository_contract.dart';
import 'SpecificTimeslotStates.dart';

class SpecificTimeSlotVM extends Cubit<SpecificTimeSlotStates> {
  SpecificTimeSlotVM(this.repoContract) : super(SpecificTimeSlotInitialState());
  AuthRepoContract repoContract;
  Future<TimeSlot> getSpecificTimeSlot(int timeslotId) async {
    try {
      emit(SpecificTimeSlotLoadingState(loadingMessage: "Loading..."));
      var response = await repoContract.specificTimeSlot(timeslotId);
      if (response.date==null) {
        emit(SpecificTimeSlotErrorState(errorMessage: 'Empty response')); // Handle empty response
        print('Failed to fetch timeslot. Response is empty.');
      } else {
        emit(SpecificTimeSlotSuccessState(response: response));
        print('timeslot fetched successfully: $response');
      }
      return response;
    } catch (e) {
      emit(SpecificTimeSlotErrorState(errorMessage: 'Error fetching timeslot: $e')); // Handle error
      return TimeSlot(date: "");
    }
  }
}
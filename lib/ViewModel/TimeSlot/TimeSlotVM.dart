import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Model/data/model/Response.dart';
import 'package:gp/Repository/repository/repository/auth_repository_contract.dart';
import 'package:gp/ViewModel/TimeSlot/TimeSlotStates.dart';

class TimeSlotVM extends Cubit<TimeSlotStates> {
  TimeSlotVM(this.repoContract) : super(TimeSlotInitialState());
  AuthRepoContract repoContract;
  Future<Response> timeSlot(List<DateTime> selectedDateTimeList,int serviceID) async {
    try {
      emit(TimeSlotLoadingState(loadingMsg: "Loading...."));
      var response=await repoContract.timeSlot(selectedDateTimeList, serviceID);

      if (response.statusMsg=='success') {
        emit(TimeSlotSuccessState(response: response));
        print("Sucess to time slot::::>>>${response.message}");
        return response;

      } else {
        emit(TimeSlotErrorState(errorMsg: response.message));
        print('time slot faild:>>>> ${response.message}');
        return Response(statusMsg: "",message: "");
      }
    } catch (e) {
      emit(TimeSlotErrorState(errorMsg: e.toString()));
      print('time slot faild:>>>> ');
      return Response(statusMsg: "",message: "");
    }
  }
}
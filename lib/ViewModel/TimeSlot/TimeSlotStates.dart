import 'package:gp/Model/data/model/Response.dart';

abstract class TimeSlotStates{
}
class TimeSlotInitialState extends TimeSlotStates{}
class TimeSlotLoadingState extends TimeSlotStates{
  String? loadingMsg;
  TimeSlotLoadingState({required this.loadingMsg});
}
class TimeSlotErrorState extends TimeSlotStates{
  String? errorMsg;
  TimeSlotErrorState({required this.errorMsg});
}
class TimeSlotSuccessState extends TimeSlotStates{
  Response response;
  TimeSlotSuccessState({required this.response});
}


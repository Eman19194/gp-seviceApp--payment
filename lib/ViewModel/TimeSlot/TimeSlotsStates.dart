import 'package:gp/Model/data/model/AllTimeSlotsResponse.dart';

abstract class TimeSlotsStates{
}
class TimeSlotsInitialState extends TimeSlotsStates{}
class TimeSlotsLoadingState extends TimeSlotsStates{
  String? loadingMsg;
  TimeSlotsLoadingState({required this.loadingMsg});
}
class TimeSlotsErrorState extends TimeSlotsStates{
  String? errorMsg;
  TimeSlotsErrorState({required this.errorMsg});
}
class TimeSlotsSuccessState extends TimeSlotsStates{
 List<AllTimeSlotsResponse>  response;
  TimeSlotsSuccessState({required this.response});
}
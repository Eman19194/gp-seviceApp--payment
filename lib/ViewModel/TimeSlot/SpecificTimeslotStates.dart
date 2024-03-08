import '../../Model/data/model/TimeSlot.dart';

abstract class SpecificTimeSlotStates{}

class SpecificTimeSlotInitialState extends SpecificTimeSlotStates{}

class SpecificTimeSlotLoadingState extends SpecificTimeSlotStates{
  String? loadingMessage ;
  SpecificTimeSlotLoadingState({required this.loadingMessage});
}

class SpecificTimeSlotErrorState extends SpecificTimeSlotStates{
  String? errorMessage ;
  SpecificTimeSlotErrorState({this.errorMessage});
}

class SpecificTimeSlotSuccessState extends SpecificTimeSlotStates{
  /// response
  TimeSlot response ;
  SpecificTimeSlotSuccessState({required this.response});
}
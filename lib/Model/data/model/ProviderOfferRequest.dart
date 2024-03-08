/// fees : 0
/// timeSlotId : 1
/// duration : "string"

class ProviderOfferRequest {
  ProviderOfferRequest({
      this.fees, 
      this.timeSlotId, 
      this.duration,});

  ProviderOfferRequest.fromJson(dynamic json) {
    fees = json['fees'];
    timeSlotId = json['timeSlotId'];
    duration = json['duration'];
  }
  int? fees;
  int? timeSlotId;
  String? duration;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fees'] = fees;
    map['timeSlotId'] = timeSlotId;
    map['duration'] = duration;
    return map;
  }

}
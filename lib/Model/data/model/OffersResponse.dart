/// id : 1
/// fees : 0
/// timeSlotId : 2
/// duration : "00:00"

class OffersResponse {
  OffersResponse({
      this.id, 
      this.fees, 
      this.timeSlotId, 
      this.duration,
      this.status,
      });

  OffersResponse.fromJson(dynamic json) {
    id = json['id'];
    fees = json['fees'];
    timeSlotId = json['timeSlotId'];
    duration = json['duration'];
    status = json['status'];
  }
  int? id;
  int? fees;
  int? timeSlotId;
  String? duration;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['fees'] = fees;
    map['timeSlotId'] = timeSlotId;
    map['duration'] = duration;
    map['status'] = duration;
    return map;
  }
}
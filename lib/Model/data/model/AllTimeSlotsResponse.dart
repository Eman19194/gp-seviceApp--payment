/// id : 1
/// date : "2024-2-12"
/// fromTime : "09:15"

class AllTimeSlotsResponse {
  AllTimeSlotsResponse({
      this.id, 
      this.date, 
      this.fromTime,});

  AllTimeSlotsResponse.fromJson(dynamic json) {
    id = json['id'];
    date = json['date'];
    fromTime = json['fromTime'];
  }
  int? id;
  String? date;
  String? fromTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['date'] = date;
    map['fromTime'] = fromTime;
    return map;
  }

}
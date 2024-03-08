/// date : "string"
/// fromTime : "string"

class TimeSlot {
  TimeSlot({
      this.date, 
      this.fromTime,});

  TimeSlot.fromJson(dynamic json) {
    date = json['date'];
    fromTime = json['fromTime'];
  }
  String? date;
  String? fromTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['fromTime'] = fromTime;
    return map;
  }
}
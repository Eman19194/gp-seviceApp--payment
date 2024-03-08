/// statusMsg : "success"
/// message : "Service Created Successfully."
/// serviceId : 4

class MakeReqResponse {
  MakeReqResponse({
      this.statusMsg, 
      this.message, 
      this.serviceId,});

  MakeReqResponse.fromJson(dynamic json) {
    statusMsg = json['statusMsg'];
    message = json['message'];
    serviceId = json['serviceId'];
  }
  String? statusMsg;
  String? message;
  int? serviceId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusMsg'] = statusMsg;
    map['message'] = message;
    map['serviceId'] = serviceId;
    return map;
  }
}
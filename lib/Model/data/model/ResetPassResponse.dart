/// statusMsg : "success"
/// message : "Password Changed Successfully."

class ResetPassResponse {
  ResetPassResponse({
      this.statusMsg, 
      this.message,});

  ResetPassResponse.fromJson(dynamic json) {
    statusMsg = json['statusMsg'];
    message = json['message'];
  }
  String? statusMsg;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusMsg'] = statusMsg;
    map['message'] = message;
    return map;
  }

}
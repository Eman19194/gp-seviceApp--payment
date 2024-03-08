/// code : "7rEn4N"
/// statusMsg : "success"
/// message : "Reset Code Sent Successfully."

class ForgetPasswordResponse {
  ForgetPasswordResponse({
      this.code, 
      this.statusMsg, 
      this.message,});

  ForgetPasswordResponse.fromJson(dynamic json) {
    code = json['code'];
    statusMsg = json['statusMsg'];
    message = json['message'];
  }
  String? code;
  String? statusMsg;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['statusMsg'] = statusMsg;
    map['message'] = message;
    return map;
  }

}
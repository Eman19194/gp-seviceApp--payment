/// statusMsg : "fail"
/// message : "You are Already Offered this Service."

class ProvideOfferResponse {
  ProvideOfferResponse({
      this.statusMsg, 
      this.message,});

  ProvideOfferResponse.fromJson(dynamic json) {
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
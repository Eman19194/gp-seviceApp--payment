/// statusMsg : "success"
/// message : "Offer Accepted."

class AcceptOfferResponse {
  AcceptOfferResponse({
      this.statusMsg, 
      this.message,});

  AcceptOfferResponse.fromJson(dynamic json) {
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
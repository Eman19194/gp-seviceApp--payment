/// statusMsg : "success"
/// message : "Offer Declined."

class DeclineOfferResponse {
  DeclineOfferResponse({
      this.statusMsg, 
      this.message,});

  DeclineOfferResponse.fromJson(dynamic json) {
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
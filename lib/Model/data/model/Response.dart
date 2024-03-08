/// statusMsg : "success"
/// message : "Created Successfully."

class Response {
  Response({
      this.statusMsg, 
      this.message,});

  Response.fromJson(dynamic json) {
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
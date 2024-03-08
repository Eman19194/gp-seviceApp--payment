
import 'Error.dart';
import 'User.dart';

/// message : "success"
/// user : {"name":"Eman Abd Al-Muti","email":"emanmutti@gmail.com","role":"user"}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ODY4YjAxYTBmZTM1NjRlNzg1MzkwNiIsIm5hbWUiOiJFbWFuIEFiZCBBbC1NdXRpIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3MDMzMTYyMjYsImV4cCI6MTcxMTA5MjIyNn0.fG7RL9g59tq1vm5nYPoQNq0DtcWrw-u0VR6_5SInrFk"

class SignUpResponse {
  SignUpResponse({
    this.statusMsg,
    this.message,
    this.userId,});

  SignUpResponse.fromJson(dynamic json) {
    statusMsg = json['statusMsg'];
    message = json['message'];
    userId = json['userId'];
  }
  String? statusMsg;
  String? message;
  String? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusMsg'] = statusMsg;
    map['message'] = message;
    map['userId'] = userId;
    return map;
  }

}
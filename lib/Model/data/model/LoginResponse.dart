/// statusMsg : "success"
/// message : "Logged in Successfully."
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJFbWFuQGV4YW1wbGUuY29tIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiIwMjk2YWIzYi0zMWZmLTQ1NzItYTU5NC1mOTc5ZGY0NjhmMTEiLCJqdGkiOiIyNWNkMmMwMC00MGEyLTQ3NGItYjc2OS1lNmFhZjRlNzFkN2MiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJDdXN0b21lciIsImV4cCI6MTcxNjk3MDA0NiwiaXNzIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NDQzNjYiLCJhdWQiOiJodHRwczovL2xvY2FsaG9zdDo0NDM2NiJ9.ITEbBmEEUMp88Aep5jHttWwr1ovn_qeb2GtWR1dRh_c"
/// expiration : "2024-05-29T11:07:26.2668453+03:00"

class LoginResponse {
  LoginResponse({
      this.statusMsg, 
      this.message, 
      this.token, 
      this.expiration,});

  LoginResponse.fromJson(dynamic json) {
    statusMsg = json['statusMsg'];
    message = json['message'];
    token = json['token'];
    expiration = json['expiration'];
  }
  String? statusMsg;
  String? message;
  String? token;
  String? expiration;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusMsg'] = statusMsg;
    map['message'] = message;
    map['token'] = token;
    map['expiration'] = expiration;
    return map;
  }

}
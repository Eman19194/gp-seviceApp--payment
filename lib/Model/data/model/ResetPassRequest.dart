/// email : "emanfathy19194@gmail.com"
/// password : "stringEman123@"
/// confirmPassword : "stringEman123@"

class ResetPassRequest {
  ResetPassRequest({
      this.email, 
      this.password, 
      this.confirmPassword,});

  ResetPassRequest.fromJson(dynamic json) {
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
  }
  String? email;
  String? password;
  String? confirmPassword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    map['confirmPassword'] = confirmPassword;
    return map;
  }

}
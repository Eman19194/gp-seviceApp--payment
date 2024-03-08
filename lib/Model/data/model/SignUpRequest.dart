/// email : "user@example.com"
/// password : "string"
/// confirmPassword : "string"

class SignUpRequest {
  SignUpRequest({
    this.email,
    this.password,
    this.confirmPassword,});

  SignUpRequest.fromJson(dynamic json) {
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
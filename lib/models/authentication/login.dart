class UserLoginModel {
  bool? status;
  String? message;
  UserLogin? data;

  UserLoginModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return UserLoginModel(
      status: json['status'],
      message: json['message'],
      data: UserLogin.fromJson(json['data']),
    );
  }
}

class UserLogin {
  String? email;
  String? password;
  String? deviceName;

  UserLogin({
    this.email,
    this.password,
    this.deviceName,
  });

  UserLogin.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    deviceName = json['device_name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['device_name'] = this.deviceName;
    return data;
  }
}

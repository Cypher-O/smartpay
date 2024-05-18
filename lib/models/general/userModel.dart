import 'package:smartpay/utilities/imports/generalImport.dart';

class UserModel {
  bool? status;
  String? message;
  UserDetails? data;
  // UserData? userData;

  UserModel({
    this.status,
    this.message,
    this.data,
    // this.userData,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? UserDetails.fromJson(json['data']) : null,
      // userData: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserData {
  UserDetails? user;
  String? token;

  UserData({this.user, this.token});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: json['user'] != null ? UserDetails.fromJson(json['user']) : null,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}




// import 'package:smartpay/utilities/imports/generalImport.dart';

// class UserModel {
//   String? status;
//   String? message;
//   RegisterUser? data;

//   UserModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       status: json['status'],
//       message: json['message'],
//       data: RegisterUser.fromJson(json['data']),
//     );
//   }
// }

import 'package:smartpay/models/authentication/register.dart';
import 'package:smartpay/models/general/userModel.dart';

class UserLoginModel {
  bool? status;
  String? message;
  UserData? data;

  UserLoginModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return UserLoginModel(
      status: json['status'],
      message: json['message'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class ApiErrorHandler {
  static String getErrorMessage(Map<String, dynamic> response) {
    if (response.containsKey('errors') &&
        response['errors'] is Map<String, dynamic>) {
      final errors = response['errors'] as Map<String, dynamic>;
      final errorMessages = <String>[];

      errors.forEach((key, value) {
        if (value is List<dynamic>) {
          errorMessages.addAll(value.cast<String>());
        } else if (value is String) {
          errorMessages.add(value);
        }
      });

      if (errorMessages.isNotEmpty) {
        return errorMessages.join(', ');
      }
    }

    return response['message'] ?? 'An error occurred during login.';
  }
}

// class UserLogin {
//   String? email;
//   String? password;
//   String? deviceName;

//   UserLogin({
//     this.email,
//     this.password,
//     this.deviceName,
//   });

//   UserLogin.fromJson(Map<String, dynamic> json) {
//     email = json['email'];
//     password = json['password'];
//     deviceName = json['device_name'];
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['email'] = this.email;
//     data['password'] = this.password;
//     data['device_name'] = this.deviceName;
//     return data;
//   }
// }

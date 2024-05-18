import 'package:smartpay/utilities/imports/generalImport.dart';

Future userLoginService({
  required String emailAddress,
  required String password,
  required String deviceName,
}) async {
  Map<String, String> requestHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };
  Map<String, dynamic> data = {
    "email": emailAddress,
    "password": password,
    "device_name": deviceName,
  };

  try {
    final response = await post(
      Uri.parse(loginUrl),
      headers: requestHeaders,
      body: json.encode(data),
    );

    debugPrint("REQUEST URL IS $loginUrl, RESPONSE IS ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> decodedResponse = json.decode(response.body);
      return UserLoginModel.fromJson(decodedResponse);
    } else {
      debugPrint("Error logging User in: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    debugPrint("Exception occurred: $e");
    return null;
  }
}


// Future userLoginService({
//   required String emailAddress,
//   required String password,
//   required String deviceName,
// }) async {
//   Map<String, String> requestHeaders = {
//     "Accept": "application/json",
//     "Content-Type": "application/json",
//   };
//   Map<String, dynamic> data = {
//     "email": emailAddress,
//     "password": password,
//     "device_name": deviceName,
//   };

//   try {
//     final response = await post(
//       Uri.parse(loginUrl),
//       headers: requestHeaders,
//       body: json.encode(data),
//     );

//     debugPrint(
//         "REQUEST URL IS $loginUrl, RESPONSE IS ${response.body}");
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final Map<String, dynamic> decodedResponse = json.decode(response.body);
//       return UserLoginModel.fromJson(decodedResponse);
//     } else {
//       debugPrint("Error logging User in: $e");
//       return null;
//     }
//   } catch (e) {
//     return null;
//   }
// }

import 'package:smartpay/utilities/imports/generalImport.dart';

Future createAccountService({
  required String fullName,
  required String userName,
  required String emailAddress,
  required String country,
  required String password,
  required String deviceName,
}) async {
  Map<String, String> requestHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };
  Map<String, dynamic> data = {
    "full_name": fullName,
    "username": userName,
    "email": emailAddress,
    "country": country,
    "password": password,
    "device_name": deviceName,
  };

  try {
    final response = await post(
      Uri.parse(registerUrl),
      headers: requestHeaders,
      body: json.encode(data),
    );

    debugPrint(
        "REQUEST URL IS $verifyEmailOtpUrl, RESPONSE IS ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> decodedResponse = json.decode(response.body);
      return UserModel.fromJson(decodedResponse);
    } else {
      debugPrint("Error verifying email OTP: $e");
      return null;
    }
  } catch (e) {
    return null;
  }
}

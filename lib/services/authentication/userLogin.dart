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

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> decodedResponse = json.decode(response.body);
      return UserLoginModel.fromJson(decodedResponse);
    } else if (response.statusCode == 422) {
      final Map<String, dynamic> decodedResponse = json.decode(response.body);
      loginErrorMessage = ApiErrorHandler.getErrorMessage(decodedResponse);
      return loginErrorMessage;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

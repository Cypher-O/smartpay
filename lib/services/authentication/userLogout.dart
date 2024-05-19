import 'package:smartpay/utilities/imports/generalImport.dart';

Future userLogoutService() async {
  Map<String, String> requestHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };

  try {
    final response = await post(
      Uri.parse(logoutUrl),
      headers: requestHeaders,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> decodedResponse = json.decode(response.body);
      return ResponseModel.fromJson(decodedResponse);
    }else if (response.statusCode == 422) {
      final Map<String, dynamic> decodedResponse = json.decode(response.body);
      logoutErrorMessage = ApiErrorHandler.getErrorMessage(decodedResponse);
      return logoutErrorMessage;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

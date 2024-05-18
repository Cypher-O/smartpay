import 'package:smartpay/utilities/imports/generalImport.dart';

verifyEmailOtpService({required String emailAddress, required String token}) async {
  Map<String, String> requestHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };
  Map<String, dynamic> data = {
    "email": emailAddress,
    "token": token,
  };

  try {
    final response = await post(
      Uri.parse(verifyEmailOtpUrl),
      headers: requestHeaders,
      body: json.encode(data),
    );

    debugPrint("REQUEST URL IS $verifyEmailOtpUrl, RESPONSE IS ${response.body}");

    // final Map<String, dynamic> decodedResponse = json.decode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> decodedResponse = json.decode(response.body);
      return VerifyEmailOtp.fromJson(decodedResponse);
    } else {
      debugPrint("Error verifying email OTP: $e");
      return null;
    }
  } catch (e) {
    return null;
  }
}

import 'package:smartpay/utilities/imports/generalImport.dart';

sendEmailOtpService({required String emailAddress}) async {
  Map<String, String> requestHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };
  Map<String, dynamic> data = {
    "email": emailAddress,
  };

  try {
    final response = await post(
      Uri.parse(sendEmailOtpUrl),
      headers: requestHeaders,
      body: json.encode(data),
    );

    debugPrint("RESPONSE IS ${response.body}");

    // final Map<String, dynamic> decodedResponse = json.decode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> decodedResponse = json.decode(response.body);
      return EmailOtp.fromJson(decodedResponse);
    } else {
      debugPrint("Error sending email OTP: $e");
      return null;
    }
  } catch (e) {
    return null;
  }
}

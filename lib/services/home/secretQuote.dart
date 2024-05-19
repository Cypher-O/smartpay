import 'package:smartpay/utilities/imports/generalImport.dart';

Future secretQuoteService() async {
  Map<String, String> requestHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer $userTokenBucket"
  };

  try {
    final response = await get(
      Uri.parse(secretQuoteUrl),
      headers: requestHeaders,
    );

    debugPrint("REQUEST URL IS $secretQuoteUrl, RESPONSE IS ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> decodedResponse = json.decode(response.body);
      return SecretQuoteModel.fromJson(decodedResponse);
    }else if (response.statusCode == 422) {
      final Map<String, dynamic> decodedResponse = json.decode(response.body);
      secretQuoteErrorMessage = ApiErrorHandler.getErrorMessage(decodedResponse);
      return secretQuoteErrorMessage;
    } else {
     
      return null;
    }
  } catch (e) {
    return null;
  }
}
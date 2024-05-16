import '../../../utilities/imports/generalImport.dart';

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

Future<void> launchInWebViewOrVC(String url, BuildContext context,
    {String? socialMedia}) async {
  if (!await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.inAppWebView,
    webViewConfiguration: const WebViewConfiguration(
        headers: <String, String>{'my_header_key': 'my_header_value'}),
  )) {
    loaderWithClose(context,
        text: "Can not load, search for the name on $socialMedia!");
  }
}

void sendEmail(
    {required BuildContext context,
    String? email,
    required String subject,
    required String body}) async {
  final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: email,
    queryParameters: {
      'subject': subject,
      'body': body,
    },
  );

  try {
    bool urlLaunched = await launchUrl(_emailLaunchUri);
    if (urlLaunched) {
      debugPrint('url launch successful');
    } else {
      showCustomSnackbar(context: context, text: 'Could not launch email');
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}

launchWebLink({required BuildContext context, required String link}) async {
  debugPrint("This is the link from the method: $link");
  try {
    // final Uri uri = Uri(scheme: "https", host: link);
    bool urlLaunched = await launchUrl(
      Uri.parse(link),
      // uri,
      mode: LaunchMode.externalApplication,
    );
    if (urlLaunched) {
      debugPrint('url launch successful ---');
    } else {
      showCustomSnackbar(context: context, text: 'Could not launch url');
    }
  } catch (e) {
    debugPrint(e.toString());
    showCustomSnackbar(context: context, text: 'Error launching URL');
  }
}

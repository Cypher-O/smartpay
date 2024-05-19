import '../utilities/imports/generalImport.dart';

class BaseModel extends BaseViewModel {
  final bool _onboardingComplete = false;
  bool get isOnboardingComplete => _onboardingComplete;

  // for showing error text under text fields
  showErrorText(
      {required String text,
      required bool errorBool,
      TextAlign textAlign = TextAlign.left,
      double lineLength = 1.0}) {
    if (errorBool == true) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          S(
            h: 20 * lineLength,
            w: 343,
            child: GeneralTextDisplay(
                text, AppColors.red(), 6, 12, FontWeight.w400, 'phone',
                textAlign: textAlign),
          ),
          S(h: 4),
        ],
      );
    } else {
      return S();
    }
  }

  //For displaying a success page
  showSuccessScreen(BuildContext context, String image, String title,
      String subtitle, String buttonText, Function? callback,
      {String? navigateTo}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return SuccessWidget(
          image: image,
          title: title,
          subtitle: subtitle,
          callback: callback,
          navigateTo: navigateTo,
          buttonText: buttonText,
        );
      }),
    );
  }

  //For displaying a failure page
  showFailureScreen(BuildContext context, String title, String subtitle,
      String buttonText, Function? callback,
      {String? navigateTo}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return FailureWidget(
          title: title,
          subtitle: subtitle,
          callback: callback,
          navigateTo: navigateTo,
          buttonText: buttonText,
        );
      }),
    );
  }

  //For displaying a partial-failure page
  showHybridScreen(BuildContext context, String title, String subtitle,
      String buttonText, Function? callback,
      {String? navigateTo}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return HybridWidget(
          title: title,
          subtitle: subtitle,
          callback: callback,
          navigateTo: navigateTo,
          buttonText: buttonText,
        );
      }),
    );
  }

  String formatErrorMessage(message) {
    if (message == null) {
      return undefinedError;
    } else {
      if (message is String) {
        return message;
      } else {
        List<String> errorMessages = [];
        message.values.forEach((errorList) {
          errorMessages.addAll(errorList.cast<String>());
        });
        return errorMessages[0];
      }
    }
  }
}

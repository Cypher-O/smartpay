import '../utilities/imports/generalImport.dart';

class BaseModel extends BaseViewModel {
  final bool _onboardingComplete = false;
  bool get isOnboardingComplete => _onboardingComplete;
  // entering pin in transaction pin confirmation pin page
  String pinEntry = '';
  // transaction pin
  List<TextEditingController> pinControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  bool pinErrorBool = false;
  List<FocusNode> pinFocusNode = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];
  int attempt = 1;
  int lastIndex = 0;

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

  //remove whatever focus is in place
  void clearFocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    // if (currentFocus.hasPrimaryFocus) {
    //   currentFocus.unfocus();
    // }
    currentFocus.unfocus();
    notifyListeners();
  }

  clearOtpField() {
    lastIndex = 0;
    pinEntry = '';
    for (var i = 0; i < pinControllers.length; i++) {
      pinControllers[i].clear();
    }
    notifyListeners();
  }

  // back space count to count how many times back space is pressed
  int backSpaceCount = 0;
  // this happens when backspace is pressed
  Future onDeletePressedFunction(BuildContext context, int index) {
    debugPrint(
        '1.pinentry is ${pinEntry} and index is ${index} pinControllers[index - 1 < 0 ? 0 : index - 1].text.isNotEmpty is ${pinControllers[index - 1 < 0 ? 0 : index - 1].text.isNotEmpty}');

    if (pinControllers[index - 1 < 0 ? 0 : index - 1].text.isNotEmpty) {
      if (pinEntry.isNotEmpty) {
        pinEntry = pinEntry.substring(0, index - 1);
        pinFocusNode[index].previousFocus();
        FocusScope.of(context).previousFocus();
        pinControllers[index - 1 < 0 ? 0 : index - 1].clear();
      }
    }
    return Future.delayed(const Duration(milliseconds: 200));
  }

  updatePinField() {
    lastIndex = pinEntry.length;
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

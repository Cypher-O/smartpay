import 'package:smartpay/utilities/imports/generalImport.dart';

class SetPinViewModel extends BaseModel {
  final mainScrollController = ScrollController();
  List<TextEditingController> otpControllers =
      List.generate(5, (_) => TextEditingController());
  List<FocusNode> otpFocusNodes = List.generate(5, (_) => FocusNode());
  String? emailController;
  bool showOtpError = false;
  List<String> enteredOtp = List<String>.filled(5, '');

  // OtpLoginViewModel({required this.emailController});

// Method to update the OTP input field with the pressed value
  void updateOtpInput(BuildContext context, String value) {
    final focusedIndex = otpFocusNodes.indexWhere((node) => node.hasFocus);
    final isFirstIndex = focusedIndex == 0;

    if (focusedIndex >= 0 && focusedIndex < otpControllers.length) {
      if (value == 'delete') {
        otpControllers[focusedIndex].text = '';
        enteredOtp[focusedIndex] = '';

        if (!isFirstIndex) {
          FocusScope.of(context).requestFocus(otpFocusNodes[focusedIndex - 1]);
        }
      } else {
        otpControllers[focusedIndex].text = value;
        enteredOtp[focusedIndex] = value;

        if (focusedIndex < otpControllers.length - 1) {
          FocusScope.of(context).requestFocus(otpFocusNodes[focusedIndex + 1]);
        }
      }
    }

    // Check if all OTP input boxes are filled and update the button state
    final areAllBoxesFilled = enteredOtp.every((otp) => otp.isNotEmpty);
    setOtpError(!areAllBoxesFilled);
  }

  // Method to set the showOtpError property
  void setOtpError(bool value) {
    showOtpError = value;
    notifyListeners(); // Make sure to call notifyListeners to trigger a rebuild
  }
}

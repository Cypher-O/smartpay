import 'package:smartpay/utilities/imports/generalImport.dart';

class OtpLoginViewModel extends BaseModel {
  final mainScrollController = ScrollController();
  List<TextEditingController> otpControllers =
      List.generate(5, (_) => TextEditingController());
  List<FocusNode> otpFocusNodes = List.generate(5, (_) => FocusNode());
  String? emailController;
  bool showOtpError = false;
  List<String> enteredOtp = List<String>.filled(5, '');

  // OtpLoginViewModel({required this.emailController});

  void updateOtpInput(BuildContext context, String value) {
    // Find the index of the OTP input field that has focus
    final focusedIndex = otpFocusNodes.indexWhere((node) => node.hasFocus);

    // If an OTP input field has focus and its index is valid
    if (focusedIndex >= 0 && focusedIndex < otpControllers.length) {
      // Set the text of the corresponding OTP input field to the pressed value
      otpControllers[focusedIndex].text = value;

      // Update enteredOtp list with the entered value
      enteredOtp[focusedIndex] = value;

      // Move focus to the next OTP input field
      if (focusedIndex < otpControllers.length - 1) {
        FocusScope.of(context).requestFocus(otpFocusNodes[focusedIndex + 1]);
      } else {
        // If this is the last OTP input field, check if all boxes are filled
        // if (enteredOtp.every((otp) => otp.isNotEmpty)) {
        //   // If all boxes are filled, proceed with confirmation
        //   context.goNamed(signupFormRoute);
        // }
      }
    }
  }

  // Method to check if all OTP input boxes are filled
  bool areAllBoxesFilled() {
    return enteredOtp.every((otp) => otp.isNotEmpty);
  }

  verifyEmailOtp(BuildContext context, {bool noLoading = false}) async {
    //   for (TextEditingController? controller in otpControllers) {
    //   newUserEmailOtpBucket += controller!.text.trim();

    // Concatenate OTP from controllers into a single string
    String otp = '';
    for (TextEditingController? controller in otpControllers) {
      if (controller != null) {
        // Add a null check
        otp += controller.text.trim(); // Add null check with '!'
      }
    }

    // Assign concatenated OTP to newUserEmailOtpBucket
    newUserEmailOtpBucket = otp;
    // }
    runFunctionForApi(
      context,
      noLoading: noLoading,
      functionToRunAfterService: (value) async {
        if (value is VerifyEmailOtp && value.status) {
          debugPrint("otpptoiooir $newUserEmailOtpBucket");

          context.goNamed(signupFormRoute);
          debugPrint("OTP: $newUserEmailOtpBucket");
          debugPrint("EMAIL OTP VERIFIED SUCCESSFULLY");
          notifyListeners();
        }
      },
      functionToRunService: verifyEmailOtpService(
          emailAddress: newUserEmailBucket!, token: newUserEmailOtpBucket!),
    );
  }


  String maskEmail(String email) {
    final emailParts = email.split('@');
    if (emailParts.length != 2) {
      return email; // Invalid email format
    }

    final domain = emailParts[1];
    return '*****@$domain';
  }
  
// Method to update the OTP input field with the pressed value
  // void updateOtpInput(BuildContext context, String value) {
  //   // Find the index of the OTP input field that has focus
  //   final focusedIndex = otpFocusNodes.indexWhere((node) => node.hasFocus);

  //   // If an OTP input field has focus and its index is valid
  //   if (focusedIndex >= 0 && focusedIndex < otpControllers.length) {
  //     // Set the text of the corresponding OTP input field to the pressed value
  //     otpControllers[focusedIndex].text = value;

  //     // Move focus to the next OTP input field
  //     if (focusedIndex < otpControllers.length - 1) {
  //       FocusScope.of(context).requestFocus(otpFocusNodes[focusedIndex + 1]);
  //     }
  //   }
  // }

  // Method to set the showOtpError property
  void setOtpError(bool value) {
    showOtpError = value;
    notifyListeners(); // Make sure to call notifyListeners to trigger a rebuild
  }
}

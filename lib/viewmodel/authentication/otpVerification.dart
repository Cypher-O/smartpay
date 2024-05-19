import 'package:smartpay/utilities/imports/generalImport.dart';

class OtpLoginViewModel extends BaseModel {
  final mainScrollController = ScrollController();
  List<TextEditingController> otpControllers =
      List.generate(5, (_) => TextEditingController());
  List<FocusNode> otpFocusNodes = List.generate(5, (_) => FocusNode());
  String? emailController;
  bool showOtpError = false;
  List<String> enteredOtp = List<String>.filled(5, '');
  bool isCountdownActive = false;

  // Remaining time in seconds for the countdown
  int countdownDuration = 60;

  // Timer for the countdown
  late Timer countdownTimer;
  void startCountdown(int duration) {
    countdownDuration = duration;
    isCountdownActive = true;

    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdownDuration > 0) {
        countdownDuration--;
        notifyListeners();
      } else {
        countdownTimer.cancel();
        isCountdownActive = false;
        notifyListeners();
      }
    });
  }

  String get countdownDisplay {
    int minutes = countdownDuration ~/ 60;
    int seconds = countdownDuration % 60;
    String minutesDisplay = minutes.toString().padLeft(2, '0');
    String secondsDisplay = seconds.toString().padLeft(2, '0');
    return '$minutesDisplay:$secondsDisplay';
  }

  sendEmailOtp(BuildContext context, {bool noLoading = false}) async {
    if (isCountdownActive) notifyListeners();
    runFunctionForApi(
      context,
      noLoading: noLoading,
      functionToRunAfterService: (value) async {
        if (value is EmailOtp) {
          notifyListeners();
        } else {
          errorDialogWithClose(context, text: sendOtpErrorMessage!);
        }
      },
      functionToRunService:
          sendEmailOtpService(emailAddress: newUserEmailBucket!),
    );
  }

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

  // Method to check if all OTP input boxes are filled
  bool areAllBoxesFilled() {
    return enteredOtp.every((otp) => otp.isNotEmpty);
  }

  verifyEmailOtp(BuildContext context, {bool noLoading = false}) async {
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

    runFunctionForApi(
      context,
      noLoading: noLoading,
      functionToRunAfterService: (value) async {
        if (value is VerifyEmailOtp && value.status) {
          context.goNamed(signupFormRoute);
          notifyListeners();
        } else {
          errorDialogWithClose(context, text: verifyOtpErrorMessage!);
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

  // Method to set the showOtpError property
  void setOtpError(bool value) {
    showOtpError = value;
    notifyListeners();
  }
}

import 'package:smartpay/utilities/imports/generalImport.dart';

class SignupViewModel extends BaseModel {
  // final mainScrollController = ScrollController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;
  String incorrectPasswordString = "Password is incorrect";
  int incorrectPasswordCount = 1;
  bool isVisible = true;
  BuildContext? context;
  bool emailVerified = false;
  bool emailFunctionSatisfied = false;

  bool get obscureText => _obscureText;

  void obscureTextFunction() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  bool emailError = false;
  bool passwordError = false;

  // focus node
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  // change email function
  onChangedFunctionEmail(BuildContext context) {
    emailFocusNode.addListener(() {
      if (emailFocusNode.hasFocus == false) {
        emailError = false;
        notifyListeners();
      }
    });
    if (isValidEmail(emailController.text.trim())) {
      emailError = false;
      emailFunctionSatisfied = true;
    } else {
      emailError = true;
      emailFunctionSatisfied = false;
    }
    notifyListeners();
  }

  // change password function
  onChangedFunctionPassword() {
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus == false) {
        passwordError = false;
        notifyListeners();
      }
    });
    if (isValidPassword(passwordController.text.trim())) {
      passwordError = false;
      notifyListeners();
    } else {
      passwordError = true;
      notifyListeners();
    }
  }

  Future<bool> _validateForm() async {
    if (!isValidEmail(emailController.text.trim())) {
      emailError = true;
      notifyListeners();
      emailFocusNode.requestFocus();
      return false;
    } else {
      return true;
    }
  }

  validateAndNavigate(BuildContext context, {bool noLoading = false}) async {
    newUserEmailBucket = emailController.text.trim();
    bool validated = await _validateForm();
    if (validated) {
      context.goNamed(otpVerificationRoute);
      notifyListeners();
    }
  }
}

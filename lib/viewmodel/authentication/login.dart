import 'package:smartpay/utilities/imports/generalImport.dart';

class LoginViewModel extends BaseModel {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;
  String incorrectPasswordString = "Password is incorrect";
  int incorrectPasswordCount = 1;
  bool isVisible = true;
  BuildContext? context;
  bool emailVerified = false;

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
      notifyListeners();
    } else {
      emailError = true;
      notifyListeners();
    }
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
    } else if (!isValidPassword(passwordController.text.trim())) {
      passwordError = true;
      notifyListeners();
      passwordFocusNode.requestFocus();
      return false;
    } else {
      return true;
    }
  }

  login(BuildContext context) async {
    String os;
    if (Platform.isAndroid) {
      os = 'Android';
    } else if (Platform.isIOS) {
      os = 'iOS';
    } else {
      os = 'Other';
    }

    bool validated = await _validateForm();
    if (validated) {
      runFunctionForApi(
        context,
        functionToRunAfterService: (value) async {
          if (value != null && value is UserLoginModel) {
            newUserUserNameBucket = value.data?.user?.username;
            newUserFullNameBucket = value.data?.user?.fullName;
            newUserCountryBucket = value.data?.user?.country;
            newUserEmailBucket = value.data?.user?.email;
            newUserDevice = value.data?.user?.deviceName;

            userTokenBucket = value.data?.token;

            context.goNamed(homeRoute);
          } else {
            errorDialogWithClose(context,
                text: loginErrorMessage!, icon: Icons.error_outline_sharp);

            // Handle error case here, such as displaying an error message to the user
          }
        },
        functionToRunService: userLoginService(
          emailAddress: emailController.text.trim(),
          password: passwordController.text.trim(),
          deviceName: os,
        ),
      );
    }
  }
}

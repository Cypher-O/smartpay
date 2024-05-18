import 'package:smartpay/models/authentication/login.dart';
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
    clearFocus(context);
    String? deviceName;
    if (kIsWeb) {
      // Some web specific code there
      deviceName = 'web';
    } else {
      if (defaultTargetPlatform == TargetPlatform.android) {
        // Android-specific code
        AndroidDeviceInfo? androidInfo = await deviceInfo.androidInfo;
        if (androidInfo != null) {
          deviceName = androidInfo.device;
          notifyListeners();
          if (kDebugMode) {
            debugPrint('Running on ${androidInfo.device}');
          }
        } else {
          // Handle the case when Android device information is null
          deviceName = 'Unknown Android device';
          // Optionally, you may want to log or print an error message
          print('Error: Android Device Info is null');
        }
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceName = iosInfo.name;
        if (kDebugMode) {
          debugPrint('Running on ${iosInfo.name}');
        } // iOS-specific code
      } else {
        // Handle the case when none of the specified platforms is detected
        deviceName = 'Unknown platform';
      }
    }
    bool validated = await _validateForm();
    if (validated) {
      runFunctionForApi(
        context,
        functionToRunAfterService: (value) async {
          debugPrint(
              "${emailController.text.trim()}, ${passwordController.text.trim()}, ${deviceName}");
          if (value != null && value is UserLoginModel) {
            debugPrint("USER LOGIN SUCCESSFULLY");
            // userTokenBucket = value.;
            debugPrint("token from user $userTokenBucket");
            context.goNamed(homeRoute);
          } else {
            debugPrint("Error occurred during login.");
            // Handle error case here, such as displaying an error message to the user
          }
        },
        functionToRunService: userLoginService(
            emailAddress: emailController.text.trim(),
            password: passwordController.text.trim(),
            deviceName: deviceName!),
      );
    }
  }
}

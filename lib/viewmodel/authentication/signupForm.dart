import 'package:smartpay/utilities/imports/generalImport.dart';

class SignupFormViewModel extends BaseModel {
  // final mainScrollController = ScrollController();
  final fullNameController = TextEditingController();
  final userNameController = TextEditingController();
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

  bool fullNameError = false;
  bool userNameError = false;
  bool passwordError = false;

  // focus node
  FocusNode fullNameFocusNode = FocusNode();
  FocusNode userNameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  // change email function
  onChangedFunctionEmail(BuildContext context) {
    fullNameFocusNode.addListener(() {
      if (fullNameFocusNode.hasFocus == false) {
        fullNameError = false;
        notifyListeners();
      }
    });
    if (isValidEmail(fullNameController.text.trim())) {
      fullNameError = false;
      // emailFunctionSatisfied = true;
      // notifyListeners();
    } else {
      fullNameError = true;
      // emailFunctionSatisfied = false;
      // notifyListeners();
    }
    notifyListeners();
  }

  // change name function
  onChangedFunctionFullName(BuildContext context) {
    fullNameFocusNode.addListener(() {
      if (fullNameFocusNode.hasFocus == false) {
        fullNameError = !validateName(fullNameController.text);
        notifyListeners();
      }
    });
    fullNameError = !validateName(fullNameController.text);
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
    if (!isValidEmail(fullNameController.text.trim()) ||
        emailVerified == false) {
      fullNameError = true;
      notifyListeners();
      fullNameFocusNode.requestFocus();
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
}

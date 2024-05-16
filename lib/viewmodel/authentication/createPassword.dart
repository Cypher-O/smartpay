import '../../utilities/imports/generalImport.dart';

class CreatePasswordViewModel extends BaseModel {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  
  bool _obscureText = true;
  bool get obscureText => _obscureText;
  // bool get obS

  void obscureTextFunction() {
    _obscureText = !_obscureText;
    notifyListeners();
  }
  // bool to check for error in text field
  bool passwordError = false;
  bool confirmPasswordError = false;

  // focus node
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  // ? function and parameters for obscure text
  bool showPassword = true;
  bool showConfirmPassword = true;

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

// change confirm passwor function
  onChangedFunctionConfirmPassword() {
    confirmPasswordFocusNode.addListener(() {
      if (confirmPasswordFocusNode.hasFocus == false) {
        confirmPasswordError = false;
        notifyListeners();
      }
    });
    if (!isValidPassword(confirmPasswordController.text.trim()) ||
        passwordController.text.trim() !=
            confirmPasswordController.text.trim()) {
      confirmPasswordError = true;
      notifyListeners();
    } else {
      confirmPasswordError = false;
      notifyListeners();
    }
  }

  // remove text obscurity
  showTextFunction({required ObscureTextEnum value}) {
    if (value == ObscureTextEnum.password) {
      showPassword = !showPassword;
      notifyListeners();
    } else if (value == ObscureTextEnum.confirmPassword) {
      showConfirmPassword = !showConfirmPassword;
      notifyListeners();
    }
  }

  Future<bool> _validateForm() async {
    if (!isValidPassword(passwordController.text.trim())) {
      passwordError = true;
      notifyListeners();
      passwordFocusNode.requestFocus();
      return false;
    } else if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      confirmPasswordError = true;
      notifyListeners();
      confirmPasswordFocusNode.requestFocus();
      return false;
    } else {
      return true;
    }
  }

  //complete signup process

}

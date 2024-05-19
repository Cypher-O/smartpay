import 'package:smartpay/utilities/imports/generalImport.dart';

class SignupFormViewModel extends BaseModel {
  // final mainScrollController = ScrollController();
  final fullNameController = TextEditingController();
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  String incorrectPasswordString = "Password is incorrect";
  int incorrectPasswordCount = 1;
  bool isVisible = true;
  BuildContext? context;
  bool emailVerified = false;
  bool emailFunctionSatisfied = false;

  List<Countries> countriesList = [];
  bool get obscureText => _obscureText;

  void obscureTextFunction() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  bool showPassword = true;
  bool showConfirmPassword = true;

  showTextFunction({required ObscureTextEnum value}) {
    if (value == ObscureTextEnum.password) {
      showPassword = !showPassword;
      notifyListeners();
    } else if (value == ObscureTextEnum.confirmPassword) {
      showConfirmPassword = !showConfirmPassword;
      notifyListeners();
    }
  }

  // String? selectedCountry;

  bool fullNameError = false;
  bool userNameError = false;
  bool selectedCountryError = false;
  bool passwordError = false;
  bool confirmPasswordError = false;
  bool phoneError = false;

  // focus node
  FocusNode fullNameFocusNode = FocusNode();
  FocusNode userNameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode selectedCountryFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  // change email function
  onChangedFunctionUserName(BuildContext context) {
    userNameFocusNode.addListener(() {
      if (userNameFocusNode.hasFocus == false) {
        userNameError = !validateName(userNameController.text);
        notifyListeners();
      }
    });
    userNameError = !validateName(userNameController.text);
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

  onChangedFunctionPhone(BuildContext context) {
    phoneFocusNode.addListener(() {
      if (phoneFocusNode.hasFocus == false) {
        phoneError = false;
        notifyListeners();
      }
    });
    if (ValidatePhoneNumber().isValidPhone(phoneController.text.trim())) {
      phoneError = false;
      notifyListeners();
    } else {
      phoneError = true;
      notifyListeners();
    }
  }

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

  onChangedFunctionConfirmPassword() {
    confirmPasswordFocusNode.addListener(() {
      if (!confirmPasswordFocusNode.hasFocus) {
        if (isValidPassword(confirmPasswordController.text.trim()) &&
            passwordController.text.trim() ==
                confirmPasswordController.text.trim()) {
          confirmPasswordError = false;
        } else {
          confirmPasswordError = true;
        }
        notifyListeners();
      }
    });

    if (isValidPassword(confirmPasswordController.text.trim()) &&
        passwordController.text.trim() ==
            confirmPasswordController.text.trim()) {
      confirmPasswordError = false;
    } else {
      confirmPasswordError = true;
    }
    notifyListeners();
  }

  getCountries(BuildContext context, {bool noLoading = false}) {
    runFunctionForApi(context, noLoading: noLoading,
        functionToRunAfterService: (value) async {
      countriesList = value;
      notifyListeners();
    }, functionToRunService: getCountriesService());
  }

  Future<bool> _validateForm() async {
    if (fullNameController.text.length <= 5) {
      fullNameError = true;
      notifyListeners();
      fullNameFocusNode.requestFocus();
    } else if (userNameController.text.length <= 5) {
      userNameError = true;
      notifyListeners();
      userNameFocusNode.requestFocus();
    }
    // else if (selectedCountry == null) {
    //   selectedCountryError = true;
    //   notifyListeners();
    //   selectedCountryFocusNode.requestFocus();
    //   return false;
    // }
    else if (!isValidPassword(passwordController.text.trim())) {
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
    }
    return true;
  }

  createAccount(BuildContext context) async {
    String? deviceName;
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
      runFunctionForApi(context, functionToRunAfterService: (value) async {
        if (value is UserModel) {
          if (value.status == true) {
            userBucket = value;
            newUserUserNameBucket = value.data?.user?.username;
            newUserFullNameBucket = value.data?.user?.fullName;
            newUserCountryBucket = value.data?.user?.country;
            newUserEmailBucket = value.data?.user?.email;
            newUserDevice = value.data?.user?.deviceName;

            userTokenBucket = value.data?.token;

            notifyListeners();

            context.goNamed(setPinCodeRoute);
          } else {
            errorDialogWithClose(context,
                text: registerErrorMessage!, icon: Icons.error_outline_sharp);
          }
        } else {
          errorDialogWithClose(context,
              text: registerErrorMessage!, icon: Icons.error_outline_sharp);
        }
      },
          functionToRunService: createAccountService(
            fullName: fullNameController.text.trim(),
            userName: userNameController.text.trim(),
            emailAddress: newUserEmailBucket!,
            country: selectedCountryString!,
            password: passwordController.text.trim(),
            deviceName: os,
          ));
    }
  }
}

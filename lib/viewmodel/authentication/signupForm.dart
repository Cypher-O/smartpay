import 'package:smartpay/utilities/imports/generalImport.dart';

class SignupFormViewModel extends BaseModel {
  // final mainScrollController = ScrollController();
  final fullNameController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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

  // String? selectedCountry;

  bool fullNameError = false;
  bool userNameError = false;
  bool selectedCountryError = false;
  bool passwordError = false;
  bool confirmPasswordError = false;

  // focus node
  FocusNode fullNameFocusNode = FocusNode();
  FocusNode userNameFocusNode = FocusNode();
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

  // onChangedFunctionConfirmPassword() {
  //   confirmPasswordFocusNode.addListener(() {
  //     if (confirmPasswordFocusNode.hasFocus == false) {
  //       confirmPasswordError = false;
  //       notifyListeners();
  //     }
  //   });
  //   if (isValidPassword(confirmPasswordController.text.trim()) ||
  //       passwordController.text.trim() !=
  //           confirmPasswordController.text.trim()) {
  //     confirmPasswordError = false;
  //     notifyListeners();
  //   } else {
  //     confirmPasswordError = true;
  //     notifyListeners();
  //   }
  // }

  getCountries(BuildContext context, {bool noLoading = false}) {
    runFunctionForApi(context, noLoading: noLoading,
        functionToRunAfterService: (value) async {
      countriesList = value;
      // Print the items here
      for (var country in countriesList) {
        debugPrint('Country: ${country.countryName}');
        debugPrint('Country Code: ${country.countryCode}');
        debugPrint('Flag URL: ${country.flagUrl}');
        debugPrint('----------------------------------------');
      }
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
    // else {
    return true;
    // }
  }

  createAccount(BuildContext context) async {
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
    // debugPrint("Tap on the button");

    if (validated) {
      // debugPrint("Tap on the button");
      // newUserFullNameBucket = fullNameController.text.trim();
      // newUserUserNameBucket = userNameController.text.trim();
      // newUserCountryBucket = selectedCountry!.toUpperCase();
      // debugPrint(
      //     "$newUserFullNameBucket}, ${newUserUserNameBucket} ${newUserCountryBucket}");

      runFunctionForApi(context, functionToRunAfterService: (value) async {
        debugPrint("Tap on the button");
        // newUserFullNameBucket = fullNameController.text.trim();
        // newUserUserNameBucket = userNameController.text.trim();
        // newUserCountryBucket = selectedCountryString ?? "Unknown";
        debugPrint(
            "${newUserFullNameBucket}, ${newUserUserNameBucket}, ${selectedCountryString}, ${passwordController.text.trim()}, ${newUserEmailBucket}, ${deviceName}");

        if (value is UserModel) {
          if (value.status == true) {
            debugPrint('USER REGISTERED SUCCESSFULLY');
            userBucket = value;
            notifyListeners();

            context.goNamed(homeRoute);
          } else {
            loaderWithClose(context,
                text: formatErrorMessage(value.message), removePage: false);
          }
        }

        // else if (value is Map<String, dynamic>) {
        //   loaderWithClose(context,
        //       text: formatErrorMessage(value['message']), removePage: false);
        // } else {
        //   loaderWithClose(context,
        //       text: "An unknown error occurred.", removePage: false);
        // }
      },
          functionToRunService: createAccountService(
            // fullName: newUserFullNameBucket!,
            fullName: fullNameController.text.trim(),
            userName: userNameController.text.trim(),
            emailAddress: newUserEmailBucket!,
            country: selectedCountryString!,
            password: passwordController.text.trim(),
            deviceName: deviceName!,
          ));
    }
  }

  // change password function
  // onChangedFunctionPassword() {
  //   passwordFocusNode.addListener(() {
  //     if (passwordFocusNode.hasFocus == false) {
  //       passwordError = false;
  //       notifyListeners();
  //     }
  //   });
  //   if (isValidPassword(passwordController.text.trim())) {
  //     passwordError = false;
  //     notifyListeners();
  //   } else {
  //     passwordError = true;
  //     notifyListeners();
  //   }
  // }
}

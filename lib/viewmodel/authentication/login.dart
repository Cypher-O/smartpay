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
    if (!isValidEmail(emailController.text.trim()) || emailVerified == false) {
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

  // login(BuildContext context) async {
  //   clearFocus(context);
  //   bool validated = await _validateForm();
  //   if (validated) {
  //     try {
  //       if (kIsWeb) {
  //         deviceDetails = 'web platform';
  //       } else if (defaultTargetPlatform == TargetPlatform.android) {
  //         AndroidDeviceInfo? androidInfo = await deviceInfo.androidInfo;
  //         if (androidInfo != null) {
  //           deviceDetails = androidInfo.toString();
  //           notifyListeners();
  //         } else {
  //           deviceDetails = 'No Android device information available';
  //           print('Error: Android Device Info is null');
  //         }
  //       } else if (defaultTargetPlatform == TargetPlatform.iOS) {
  //         IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //         deviceDetails = iosInfo.toString();
  //       } else {
  //         deviceDetails = 'web platform';
  //       }

  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       String? locationDataString = prefs.getString('location_details');

  //       List<dynamic> locationArray = [];
  //       // if (locationDataString != null) {
  //       // Map<String, dynamic> locationData = json.decode(locationDataString);
  //       Map<String, dynamic> locationData =
  //           json.decode(locationDataString ?? "{}");
  //       locationArray = [
  //         locationData['latitude'],
  //         locationData['longitude'],
  //         locationData['city'],
  //         locationData['state'],
  //         locationData['country'],
  //         locationData['address'],
  //       ];

  //       String loginId;
  //       if (phoneController.text.trim().contains('@')) {
  //         // If the phone controller contains an "@" symbol, consider it as an email
  //         loginId = phoneController.text.trim();
  //       } else {
  //         // Otherwise, format it as a phone number with the default code
  //         loginId = formatPhoneNumber(phoneController.text.trim());
  //       }

  //       runFunctionForApi(
  //         context,
  //         functionToRunAfterService: (value) async {
  //           if (value is UserModel) {
  //             debugPrint('USER LOGIN SUCCESSFULLY');

  //             await LocalStorage.setBool('onboarded', true);
  //             await LocalStorage.setString(tokenKey, value.data!.token!);
  //             await LocalStorage.setBool('createAccountSaved', false);
  //             await LocalStorage.setBool('createAccountSaved2', false);
  //             await LocalStorage.setBool('phoneNumberVerified', false);
  //             userTokenBucket = value.data!.token!;
  //             startLogoutTimer(context, seconds: value.data!.timeout);
  //             //set Sentry user
  //             Sentry.configureScope((scope) {
  //               scope.setUser(SentryUser(
  //                   id: '${value.data!.user!.id}',
  //                   name:
  //                       '${value.data!.user!.firstname} ${value.data!.user!.lastname}',
  //                   email: '${value.data!.user!.email}'));
  //             });
  //             context.goNamed(homeRoute);
  //           } else {
  //             if ((value['message'] as String) == incorrectPasswordString) {
  //               incorrectPasswordCount = incorrectPasswordCount + 1;
  //               if (incorrectPasswordCount > 5) {
  //                 showAccountBlockedModal(context, () {
  //                   Navigator.of(context).pop();
  //                 }, 'Password attempt exceeded');
  //               } else {
  //                 loaderWithClose(context,
  //                     text: formatErrorMessage(value['message']),
  //                     removePage: false);
  //               }
  //             } else {
  //               loaderWithInfo(
  //                 context,
  //                 text: formatErrorMessage(value['message']),
  //                 title: "Account Locked",
  //                 onTap: () {
  //                   Navigator.of(context).pop();
  //                   showCustomerCareModal(context);
  //                 },
  //                 cancelTap: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 cancelText: "Close",
  //                 acceptText: 'Support',
  //                 iconColor: AppColors.red(),
  //               );
  //             }
  //           }
  //         },
  //         functionToRunService: loginService(
  //           loginAttempt: incorrectPasswordCount,
  //           // phoneNumber: formatPhoneNumber(phoneController.text.trim()),
  //           loginId: loginId,
  //           password: passwordController.text,
  //           deviceModel: (deviceDetails is AndroidDeviceInfo)
  //               ? 'android'
  //               : (deviceDetails is IosDeviceInfo)
  //                   ? 'ios'
  //                   : deviceDetails.toString(),
  //           deviceVersion: kIsWeb
  //               ? 'web'
  //               : (deviceDetails is AndroidDeviceInfo)
  //                   ? deviceDetails.version.release.toString()
  //                   : (deviceDetails is IosDeviceInfo)
  //                       ? deviceDetails.systemVersion.toString()
  //                       : deviceDetails.toString(),
  //           deviceDetails: deviceDetails.toString(),
  //           geoLocation: locationArray,
  //         ),
  //       );
  //       // }
  //       // else {
  //       //   debugPrint('Location data not available');
  //       //   // Handle the case when location data is not available
  //       // }
  //     } catch (e) {
  //       if (kDebugMode) {
  //         debugPrint('Error in login function: $e');
  //       }
  //       // Handle error
  //     }
  //   }
  // }
}

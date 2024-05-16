// creating a function to prevent calling catch error and try catch in multiple places

import '../../../utilities/imports/generalImport.dart';

Future<bool> runFunctionForApi(
  BuildContext context, {
  required Future functionToRunService,
  bool noLoading = false,
  required Function(dynamic) functionToRunAfterService,
}) async {
  try {
    // loading
    if (noLoading == false) {
      loadingDialog(context, text: "");
    }

    // Adding a timeout of 1 minute
    final timeoutDuration = Duration(seconds: 60);

    // Run the function with timeout
    final result = await Future.any([
      // run function
      functionToRunService,
      Future.delayed(timeoutDuration, () => 'timeout')
    ]);
    //check if timeout was exceeded
    if (result == 'timeout') {
      // The API call took longer than 1 minute, handle accordingly
      if (!noLoading) Navigator.pop(context);
      // Show an appropriate message to the user
      // loaderWithClose(context, text: "API call timed out");
      loaderWithClose(context, text: "Network busy. Retry", removePage: false);

      return false;
    } else {
      // API call completed within 1 minute, proceed as normal
      try {
        if (noLoading == false) Navigator.pop(context);
        functionToRunAfterService(result);
      } catch (onError) {
        if (onError is SocketException && noLoading == false) {
          loaderWithClose(context, text: networkError);
          if (noLoading == false) Navigator.pop(context);
        } else if (onError is FormatException && noLoading == false) {
          Navigator.pop(context);
          // this will occur if the user is unauthenticated, not you can check the stack trace error printedif
          // showLogoutModal(context);
          debugPrint('error is $onError}');
        } else {
          if (noLoading == false) {
            Navigator.pop(context);
            debugPrint('error is $onError}');
            loaderWithClose(context, text: undefinedError);
          }
        }
      }
      return true;
    }
  } catch (onError, stacktrace) {
    debugPrint('stackStrace is ${stacktrace.toString()}');

    if (onError is SocketException && noLoading == false) {
      if (noLoading == false) Navigator.pop(context);
      loaderWithClose(context, text: networkError);
    } else if (onError is FormatException && noLoading == false) {
      Navigator.pop(context);
      // this will occur if the user is unauthenticated, if not you can check the stack trace error printed
      // showLogoutModal(context);
    } else {
      if (noLoading == false) {
        Navigator.pop(context);
        loaderWithClose(context, text: undefinedError);
      }
    }
    return false;
  }
}

// void showLogoutModal(BuildContext context) {
//   final model = BaseModel();
//   loaderWithInfo(context,
//       text: 'Kindly Login in Again',
//       title: "Session Expired",
//       // title: "Unauthenticated",
//       iconColor: AppColors.red(),
//       onTap: () {
//         model.logoutFunction(navigateTo: loginRoute);
//       },
//       cancelText: 'Cancel',
//       acceptText: 'Login',
//       cancelTap: () {
//         model.logoutFunction();
//       });
// }

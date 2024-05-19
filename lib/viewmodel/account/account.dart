import 'package:smartpay/utilities/imports/generalImport.dart';

class AccountViewModel extends BaseModel {
  logoutFunction(BuildContext context, {String? navigateTo}) {
    runFunctionForApi(
      context,
      functionToRunAfterService: (value) {
        if (value is ResponseModel) {
          LocalStorage.clear();
          if (navigateTo == null) {
            router.go('/');
          } else {
            router.goNamed(navigateTo);
          }
          notifyListeners();
        } else {
          errorDialogWithClose(context, text: logoutErrorMessage!);
        }
      },
      functionToRunService: userLogoutService(),
    );
  }

  void showLogoutConfirmationDialog(BuildContext context) {
    loaderWithInfo(
      context,
      title: "Logout",
      text: "Are you sure you want to logout?",
      icon: Icons.exit_to_app_rounded,
      onTap: () {
        // User tapped "Yes" to logout
        logoutFunction(context, navigateTo: null);
        Navigator.pop(context);
      },
      cancelText: "No",
      cancelTap: () {
        Navigator.pop(context);
      },
      acceptText: "Yes",
      acceptColor: AppColors.blue(),
      iconColor: AppColors.blue(),
    );
  }
}

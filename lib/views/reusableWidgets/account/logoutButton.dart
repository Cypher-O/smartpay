import '/../../../utilities/imports/generalImport.dart';

Widget logoutButton(
    {required BuildContext context, required Function callback}) {
  return ButtonWidget(
    () {
      callback();
    },
    AppColors.white(),
    170,
    48,
    GeneralTextDisplay(
        'Log out', AppColors.blue(), 1, 14, FontWeight.w500, 'Log out '),
    Alignment.center,
    8,
    noElevation: 0,
    borderColor: AppColors.blue(),
  );
}

import '../../../utilities/imports/generalImport.dart';

Widget loading({Color? color}) {
  return S(
    h: 45,
    w: 45,
    child: CircularProgressIndicator(
        strokeWidth: 5.5,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.white()),
        backgroundColor: AppColors.green()),
  );
}

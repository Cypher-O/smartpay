import '../../../utilities/imports/generalImport.dart';

Widget amountPrefixIcon(BuildContext context, {bool boldSign = false}) {
  return Padding(
    padding: EdgeInsets.only(
        left: sS(context).cW(width: (10)),
        right: sS(context).cW(width: (2.5)),
        bottom: sS(context).cH(height: (2))),
    child: GeneralTextDisplay(
        '₦',
        boldSign ? AppColors.black() : AppColors.gray2(),
        1,
        15,
        FontWeight.w500,
        '₦'),
  );
}

import '../../../utilities/imports/generalImport.dart';

Widget otpField(
    {required BuildContext context,
    required TextEditingController pin,
    required double height,
    required double width,
    required String hintText,
    required TextStyle textStyle,
    required onChanged,
    required FocusNode focusNode,
    required bool autoFocus,
    int pinLength = 6}) {
  return Container(
    height: height,
    width: width,
    //  margin: EdgeInsets.only(right: 4, left: 4, bottom: 18),
    alignment: Alignment.center,

    child: TextFormField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLines: 2,
        focusNode: focusNode,
        controller: pin,
        autofocus: autoFocus,
        cursorColor: AppColors.black(),
        style: textStyle,
        inputFormatters: [
          LengthLimitingTextInputFormatter(pinLength),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: textStyle.copyWith(color: AppColors.black().withOpacity(0.25)),
          border: InputBorder.none,
        ),
        onChanged: onChanged),
  );
}


import '../../../utilities/imports/generalImport.dart';

// Widget dropdownFieldWidget(BuildContext context,
//     {required List<String> items,
//     required String hintText,
//     bool errorTextActive = false,
//     bool isCountry = false,
//     bool isAccountTransfer = false,
//     bool setInitialValue = false,
//     bool contextNeeded = false,
//     double width = 358,
//     required Function callback,
//     String? value,
//     FocusNode? focusNode}) {
//   return Container(
//     // height: sS(context).cH(height: 50),
//     constraints: BoxConstraints(
//       maxWidth: sS(context).cW(width: width),
//     ),
//     child: ButtonTheme(
//       alignedDropdown: true,
//       child: DropdownButtonFormField<String>(
//         dropdownColor: AppColors.white(),
//         isDense: false,
//         focusNode: focusNode,
//         value: (setInitialValue)
//             ? (isCountry && items.length > 20)
//                 ? items[162]
//                 : items.isNotEmpty
//                     ? items[0]
//                     : ''
//             : value,
//         items: items
//             .map((item) => DropdownMenuItem<String>(
//                   value: item,
//                   child: SizedBox(
//                       width: sS(context).cW(width: width * 0.6),
//                       child: GeneralTextDisplay(item, AppColors.black(), 2, 14,
//                           FontWeight.w500, item)),
//                 ))
//             .toList(),
//         hint: Align(
//             alignment: Alignment.centerLeft,
//             child: GeneralTextDisplay(
//                 hintText,
//                 AppColors.black().withOpacity(0.5),
//                 1,
//                 14,
//                 FontWeight.w400,
//                 "")),
//         decoration: InputDecoration(
//             enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                     color: AppColors.gray5(),
//                     width: 1.0,
//                     style: BorderStyle.solid),
//                 borderRadius: BorderRadius.circular(8)),
//             focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                     color: errorTextActive == true
//                         ? AppColors.red()
//                         : AppColors.gray5(),
//                     width: 1.0,
//                     style: BorderStyle.solid),
//                 borderRadius: BorderRadius.circular(8)),
//             filled: true,
//             fillColor: Theme.of(context).hoverColor,
//             contentPadding: EdgeInsets.zero),
//         onChanged: (value) =>
//             contextNeeded ? callback(context, value) : callback(value),
//         icon: Icon(Icons.keyboard_arrow_down_rounded,
//             color: AppColors.gray3(), size: 25),
//       ),
//     ),
//   );
// }


Widget dropdownFieldWidget(BuildContext context,
    {required List<String> items,
    required String hintText,
    bool errorTextActive = false,
    bool isCountry = false,
    bool isAccountTransfer = false,
    bool setInitialValue = false,
    bool contextNeeded = false,
    bool isDisabled = false, // Added parameter
    double width = 358,
    required Function callback,
    String? value,
    FocusNode? focusNode}) {
  return Container(
    constraints: BoxConstraints(
      maxWidth: sS(context).cW(width: width),
    ),
    child: ButtonTheme(
      alignedDropdown: true,
      child: DropdownButtonFormField<String>(
        dropdownColor: AppColors.white(),
        isDense: false,
        focusNode: focusNode,
        value: (setInitialValue)
            ? (isCountry && items.length > 20)
                ? items[162]
                : items.isNotEmpty
                    ? items[0]
                    : ''
            : value,
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: SizedBox(
                      width: sS(context).cW(width: width * 0.6),
                      child: GeneralTextDisplay(item, AppColors.black(), 2, 14,
                          FontWeight.w500, item)),
                ))
            .toList(),
        hint: Align(
            alignment: Alignment.centerLeft,
            child: GeneralTextDisplay(
                hintText,
                AppColors.black().withOpacity(0.5),
                1,
                14,
                FontWeight.w400,
                "")),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.gray5(),
                    width: 1.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: errorTextActive == true
                        ? AppColors.red()
                        : AppColors.gray5(),
                    width: 1.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(8)),
            filled: true,
            fillColor: Theme.of(context).hoverColor,
            contentPadding: EdgeInsets.zero),
        onChanged: isDisabled
            ? null
            : (value) =>
                contextNeeded ? callback(context, value) : callback(value),
        icon: Icon(Icons.keyboard_arrow_down_rounded,
            color: AppColors.gray3(), size: 25),
      ),
    ),
  );
}

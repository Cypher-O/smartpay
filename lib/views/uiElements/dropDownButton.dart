import '../../utilities/imports/generalImport.dart';

class DropDown extends StatelessWidget {
  final List<String> itemList;
  final String? validatorText;
  final FocusNode? focusNode;
  final String? dropDown;
  final double? elevation;
  final Function(String) onChanged;
  final Color? containerColor, textColor, dropDownColor, focusColor;

  const DropDown(
      {super.key,
      required this.itemList,
      this.validatorText,
      required this.dropDown,
      this.focusNode,
      required this.onChanged,
      this.containerColor,
      this.textColor,
      this.elevation,
      this.dropDownColor,
      this.focusColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: sS(context).cH(height: 48),
      width: sS(context).cW(width: 358),
      padding: EdgeInsets.fromLTRB(
          sS(context).cW(width: 16), sS(context).cH(height: 2), 0, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(
            sS(context).cH(height: 8),
          )),
          color: containerColor ?? AppColors.gray6()),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: GeneralTextDisplay(
              itemList[0], AppColors.gray2(), 1, 14, FontWeight.w400, ''),
          icon: Padding(
            padding: EdgeInsets.only(right: sS(context).cW(width: 16.41)),
            child: GeneralIconDisplay(
                LineIcons.angleDown, AppColors.black(), UniqueKey(), 15),
          ),
          focusNode: focusNode,
          dropdownColor: dropDownColor ?? AppColors.white(),
          focusColor: focusColor ?? AppColors.white(),
          isExpanded: true,
          style: TextStyle(
              color: textColor, fontSize: 14, fontWeight: FontWeight.w400),
          value: dropDown,
          items: itemList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
                value: value,
                child: GeneralTextDisplay(value, textColor ?? AppColors.black(),
                    1, 14, FontWeight.w400, ''));
          }).toList(),
          onChanged: (value) {
            onChanged(value!);
          },
        ),
      ),
    );
  }
}

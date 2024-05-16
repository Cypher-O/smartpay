// this is a general back button for the pages
import '../../../utilities/imports/generalImport.dart';

Widget backButton(BuildContext context,
    {double top = 60,
    double left = 16,
    Color? color,
    Color? arrowColor,
    double? size,
    String? navigateTo,
    Function? navigator}) {
  return AdaptivePositioned(
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: (navigator != null)
              ? () {
                  navigator();
                }
              : (navigateTo != null)
                  ? () {
                      context.goNamed(navigateTo);
                    }
                  : () {
                      Navigator.pop(context);
                    },
          child: Container(
            height: size ?? 40,
            width: size ?? 40,
            decoration: BoxDecoration(
              // shape: BoxShape.circle,
              borderRadius: BorderRadius.all(Radius.circular(13.0)),
              color: AppColors.white(),
              border: Border.all(color: AppColors.gray4()),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20.5,
              color: arrowColor ?? AppColors.gray1(),
              weight: 0.5,
            ),
          ),
        ),
      ],
    ),
    top: top,
    left: left,
  );
}

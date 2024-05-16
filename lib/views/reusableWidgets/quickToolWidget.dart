import '../../../utilities/imports/generalImport.dart';

Widget quickToolWidget({
  required BuildContext context,
  required String icon,
  required String title,
  required String subtitle,
  required Color titleColor,
  required Color backgroundColor,
  required Function callback,
  String? backgroundImage,
  bool stretch = false,
  bool isBanner = false,
}) {
  return GestureDetector(
    onTap: () {
      callback();
    },
    child: Container(
      height: sS(context).cH(height: 120),
      width: stretch ? sS(context).cW(width: 354) : sS(context).cW(width: 170),
      padding: EdgeInsets.symmetric(
          horizontal: sS(context).cW(width: 8),
          vertical: sS(context).cH(height: 16)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor,
        // image: backgroundImage == null
        //     ? null
        //     : DecorationImage(
        //         image: NetworkImage(backgroundImage), fit: BoxFit.cover),
      ),
      child: isBanner
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      S(w: 4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GeneralTextDisplay(
                              title,
                              titleColor,
                              1,
                              15,
                              FontWeight.w500,
                              title,
                            ),
                            S(h: 8),
                            Expanded(
                              child: GeneralTextDisplay(
                                  subtitle,
                                  AppColors.gray1(),
                                  4,
                                  12,
                                  FontWeight.w400,
                                  ""),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      backgroundImage == null
                          ? SvgPicture.asset(icon,
                              height: sS(context).cH(height: 36))
                          : Image.network(backgroundImage, fit: BoxFit.contain),
                      S(w: 4),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //S(h: 16),
                SvgPicture.asset(
                  icon,
                  height: sS(context).cH(height: 24),
                ),
                // S(h: 12),
                GeneralTextDisplay(
                    title, titleColor, 1, 14, FontWeight.w500, title),
                GeneralTextDisplay(
                    subtitle, AppColors.gray1(), 2, 12, FontWeight.w400, ""),
              ],
            ),
    ),
  );
}

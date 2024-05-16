import '../../../utilities/imports/generalImport.dart';

Widget rewardsWidget(BuildContext context, Function callback,
    {Function? onClose}) {
  return GestureDetector(
    onTap: () {
      callback();
    },
    child: Container(
        height: sS(context).cH(height: 120),
        //width: sS(context).cW(width: 354),
        padding: EdgeInsets.symmetric(
            horizontal: sS(context).cW(width: 8),
            vertical: sS(context).cH(height: 8)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.lightGreen()),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.topRight,
                onPressed: () {},
                icon: Container(
                  height: sS(context).cH(height: 20),
                  width: sS(context).cW(width: 20),
                  decoration: BoxDecoration(
                      color: AppColors.white(), shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.close_rounded,
                    color: AppColors.red(),
                    size: sS(context).cH(height: 16),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                S(w: 4),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GeneralTextDisplay("Earn Rewards", AppColors.black(), 1, 14,
                        FontWeight.w500, 'Earn rewards'),
                    S(h: 10),
                    GeneralTextDisplay(
                        'Invite your friends to pCash and earn big!',
                        AppColors.gray1(),
                        2,
                        12,
                        FontWeight.w400,
                        'Invite your friends to pCash and earn big'),
                  ],
                ),
                const Spacer(),
                SvgPicture.asset(
                  "assets/giftbox.svg",
                  height: sS(context).cH(height: 48),
                ),
                S(w: 16),
              ],
            )
          ],
        )),
  );
}

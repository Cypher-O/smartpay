// page tab

import '../../../utilities/imports/generalImport.dart';

Widget pageTab(BuildContext context, {double? top, TabEnum? tabEnum,double? bottom}) {
    // double platformBottom = tabEnum == TabEnum.savings && Platform.isIOS ? 20 : 0;
    //  double platformBottom = kIsWeb ? 0 : (tabEnum == TabEnum.savings && Platform.isIOS ? 20 : 0);
  return Positioned(
    child: Container(
      width: sS(context).w,
      // padding: EdgeInsets.only(bottom: sS(context).cH(height: 5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // home page
          tabWidget(context,
              image:
                  tabEnum == TabEnum.home ? "homeSelected" : "homeUnselected",
              isSelected: tabEnum == TabEnum.home ? true : false,
              left: 26,
              label: "Home",
              navigation: tabEnum == TabEnum.home
                  ? () {}
                  : () {
                      context.goNamed(homeRoute);
                    }),
          // savings page
          tabWidget(context,
              image: tabEnum == TabEnum.savings
                  ? "savingsSelected"
                  : "savingsUnselected",
              isSelected: tabEnum == TabEnum.savings ? true : false,
              left: 99,
              label: "Savings",
              navigation: tabEnum == TabEnum.savings
                  ? () {}
                  : () {
                      // context.goNamed(savingsRoute);
                    }),
          // circle page
          tabWidget(context,
              image: tabEnum == TabEnum.credit
                  ? "creditSelected"
                  : "creditUnselected",
              isSelected: tabEnum == TabEnum.credit ? true : false,
              left: 172,
              label: "Credit",
              navigation: tabEnum == TabEnum.credit
                  ? () {}
                  : () {
                      // context.goNamed(creditRoute);
                    }),
          // chat page
          tabWidget(context,
              image: tabEnum == TabEnum.vas ? "vas" : "vasUnselected",
              isSelected: tabEnum == TabEnum.vas ? true : false,
              right: 100,
              label: "VAS",
              navigation: tabEnum == TabEnum.vas
                  ? () {}
                  : () {
                      // context.goNamed(vasRoute);
                    }),

          // account page
          tabWidget(context,
              image: tabEnum == TabEnum.account
                  ? "accountSelected"
                  : "accountUnselected",
              isSelected: tabEnum == TabEnum.account ? true : false,
              right: 100,
              label: "Account",
              navigation: tabEnum == TabEnum.account
                  ? () {}
                  : () {
                      // context.goNamed(accountRoute);
                    }),
        ],
      ),
    ),
    bottom: sS(context).cH(height:bottom?? 20),
    //  bottom: sS(context).cH(height: bottom ?? platformBottom),
  );
}

Widget tabWidget(context,
    {required String image,
    required String label,
    required bool isSelected,
    double? left,
    double? right,
    Function? navigation}) {
  return InkWell(
    onTap: () {
      navigation!();
    },
    child: Column(
      //mainAxisSize: MainAxisSize.min,
      //mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // home page
        SvgPicture.asset("assets/$image.svg",
            height: sS(context).cH(height: 22)),
        S(h: 3),
        //label
        GeneralTextDisplay(
            label,
            isSelected ? AppColors.green() : AppColors.gray3(),
            1,
            13,
            FontWeight.w500,
            label),
        // indicator
        S(h: 4),
        if (isSelected)
          Container(
              width: sS(context).cW(width: 14.8),
              height: sS(context).cH(height: 2),
              decoration: BoxDecoration(
                  color: AppColors.green(),
                  borderRadius: BorderRadius.circular(4)))
      ],
    ),
  );
}

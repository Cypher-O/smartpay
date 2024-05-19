import '/../../../utilities/imports/generalImport.dart';

Widget accountProfileWidget(
    {required BuildContext context,
    String? fullname,
    String? profile}) {
  String formattedFullName = capitalize(fullname ?? '');

  return Column(
    children: [
      S(h: 24),
      profile != null
          ? CircleAvatar(
              radius: sS(context).cH(height: 54),
              backgroundColor: AppColors.gray3(),
              backgroundImage: AssetImage(profile))
          : SvgPicture.asset(
              'assets/avatar/avatar.svg',
              height: sS(context).cH(height: 96),
              fit: BoxFit.cover,
            ),
      S(h: 16),
      GeneralTextDisplay('$formattedFullName',
          AppColors.black(), 1, 20, FontWeight.w500, ''),
      
    ],
  );
}

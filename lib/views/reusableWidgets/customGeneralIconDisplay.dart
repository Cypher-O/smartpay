import '../../../utilities/imports/generalImport.dart';

class customGeneralIconDisplay extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final Key iconKey;

  customGeneralIconDisplay(
      this.icon, this.iconColor, this.iconKey, this.iconSize);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      key: iconKey,
      size: sS(context).cH(height: iconSize),
      color: iconColor,
    );
  }
}

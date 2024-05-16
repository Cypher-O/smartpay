import 'package:smartpay/utilities/imports/generalImport.dart';

class RectangularTile extends StatelessWidget {
  final String? imagePath;
  const RectangularTile({
    Key? key,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 180,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey()),
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
      ),
      child: Image.asset(
        imagePath!,
        height: 20,
        width: 20,
      ),
    );
  }
}

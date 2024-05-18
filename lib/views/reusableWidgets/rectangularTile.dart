import 'package:smartpay/utilities/imports/generalImport.dart';

class RectangularTile extends StatelessWidget {
  final String? imagePath;
  const RectangularTile({
    Key? key,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 50,
          width: 120,
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey()),
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.transparent,
          ),
          child: Image.asset(
            imagePath!,
            height: 20,
            width: 20,
          ),
        ),
      ],
    );
  }
}

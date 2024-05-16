import '../../../utilities/imports/generalImport.dart';

class DividerWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  DividerWidget({Key? key, this.height, this.width, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: sS(context).cW(width: width ?? 358),
          height: sS(context).cH(height: height ?? 1),
          color: color ?? const Color.fromRGBO(22, 32, 130, 0.15),
        ),
      ],
    );
  }
}

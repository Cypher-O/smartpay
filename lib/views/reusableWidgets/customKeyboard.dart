import 'package:smartpay/utilities/imports/generalImport.dart';

class CustomKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;
   final Function() onDeletePressed;

  CustomKeyboard({required this.onKeyPressed, required this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildKey('1'),
              _buildKey('2'),
              _buildKey('3'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildKey('4'),
              _buildKey('5'),
              _buildKey('6'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildKey('7'),
              _buildKey('8'),
              _buildKey('9'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildKey('*'),
              _buildKey('0'),
              _buildDeleteButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKey(String value) {
    return InkWell(
      onTap: () => onKeyPressed(value),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.grey),
          //   borderRadius: BorderRadius.circular(10),
          // ),
          child: GeneralTextDisplay(
            value,
            AppColors.gray1(),
            2,
            22,
            FontWeight.w600,
            "",
          ),
        ),
      ),
    );
  }
    Widget _buildDeleteButton() {
    return InkWell(
      onTap: onDeletePressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: Icon(
            Icons.backspace_outlined,
            size: 22,
          ),
        ),
      ),
    );
  }
}

//   Widget _buildEraseButton() {
//     return InkWell(
//       onTap: () => onKeyPressed('x'),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
//         child: Container(
//           width: 40,
//           height: 40,
//           alignment: Alignment.center,
//           // decoration: BoxDecoration(
//           //   border: Border.all(color: Colors.grey),
//           //   borderRadius: BorderRadius.circular(10),
//           // ),
//           child: GeneralIconDisplay(
//             Icons.backspace_outlined,
//             AppColors.gray1(),
//             UniqueKey(),
//             22,
//           ),
//         ),
//       ),
//     );
//   }
// }

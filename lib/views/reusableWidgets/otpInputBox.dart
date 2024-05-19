import 'package:smartpay/utilities/imports/generalImport.dart';

class OtpInputBox extends StatelessWidget {
  final OtpLoginViewModel viewModel;
  final Function(String) onKeyPressed; // Add this callback

  const OtpInputBox({
    Key? key,
    required this.viewModel,
    required this.onKeyPressed, // Add this parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (event) => _handleKeyPress(event, context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          5,
          (index) => buildOtpTextField(context, index),
        ),
      ),
    );
  }

  void _handleKeyPress(RawKeyEvent event, BuildContext context) {
    // Handle backspace key press
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      final focusedIndex =
          viewModel.otpFocusNodes.indexWhere((node) => node.hasFocus);
      if (focusedIndex >= 0) {
        final currentController = viewModel.otpControllers[focusedIndex];
        final currentText = currentController.text;
        final selection = currentController.selection;
        if (selection.isCollapsed && selection.start > 0) {
          final updatedText = currentText.substring(0, selection.start - 1) +
              currentText.substring(selection.start);
          currentController.value = TextEditingValue(
            text: updatedText,
            selection: TextSelection.collapsed(offset: selection.start - 1),
          );
        } else if (selection.isCollapsed &&
            selection.start == 0 &&
            focusedIndex > 0) {
          currentController.clear();
          FocusScope.of(context)
              .requestFocus(viewModel.otpFocusNodes[focusedIndex - 1]);
          viewModel.otpControllers[focusedIndex - 1].clear();
        }
      }
    }
  }

  Widget buildOtpTextField(BuildContext context, int index) {
    return Container(
      color: alterWhite,
      width: 48,
      child: TextFormField(
        controller: viewModel.otpControllers[index],
        focusNode: viewModel.otpFocusNodes[index],
        keyboardType: TextInputType.none,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        maxLength: 1,
        showCursor: false,
        autofocus: index == 0,
        onChanged: (value) {
          if (value.isNotEmpty && index < 4) {
            FocusScope.of(context)
                .requestFocus(viewModel.otpFocusNodes[index + 1]);
          }

          if (index == 4 && value.isNotEmpty) {
            FocusScope.of(context).unfocus();
          }

          // Call the onKeyPressed callback with the entered value
          onKeyPressed(value);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: textOutline),
          ),
          counterText: '',
        ),
      ),
    );
  }
}


// class OtpInputBox extends StatelessWidget {
//   final OtpLoginViewModel viewModel;

//   const OtpInputBox({
//     Key? key,
//     required this.viewModel,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return RawKeyboardListener(
//       focusNode: FocusNode(),
//       onKey: (event) => _handleKeyPress(event, context),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: List.generate(
//           5,
//           (index) => buildOtpTextField(context, index),
//         ),
//       ),
//     );
//   }

//   void _handleKeyPress(RawKeyEvent event, BuildContext context) {
//     if (event is RawKeyDownEvent &&
//         event.logicalKey == LogicalKeyboardKey.backspace) {
//       final focusedIndex =
//           viewModel.otpFocusNodes.indexWhere((node) => node.hasFocus);
//       if (focusedIndex >= 0) {
//         final currentController = viewModel.otpControllers[focusedIndex];
//         final currentText = currentController.text;
//         final selection = currentController.selection;
//         if (selection.isCollapsed && selection.start > 0) {
//           final updatedText = currentText.substring(0, selection.start - 1) +
//               currentText.substring(selection.start);
//           currentController.value = TextEditingValue(
//             text: updatedText,
//             selection: TextSelection.collapsed(offset: selection.start - 1),
//           );
//         } else if (selection.isCollapsed &&
//             selection.start == 0 &&
//             focusedIndex > 0) {
//           currentController.clear();
//           FocusScope.of(context)
//               .requestFocus(viewModel.otpFocusNodes[focusedIndex - 1]);
//           viewModel.otpControllers[focusedIndex - 1].clear();
//         }
//       }
//     }
//   }

//   Widget buildOtpTextField(BuildContext context, int index) {
//     return Container(
//       color: alterWhite,
//       width: 48,
//       child: TextFormField(
//         controller: viewModel.otpControllers[index],
//         focusNode: viewModel.otpFocusNodes[index],
//         keyboardType: TextInputType.number,
//         textAlign: TextAlign.center,
//         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         maxLength: 1,
//         showCursor: false,
//         autofocus: index == 0,
//         onChanged: (value) {
//           if (value.isNotEmpty && index < 4) {
//             FocusScope.of(context)
//                 .requestFocus(viewModel.otpFocusNodes[index + 1]);
//           }

//           if (index == 4 && value.isNotEmpty) {
//             FocusScope.of(context).unfocus();
//           }
//         },
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.zero,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(color: textOutline),
//           ),
//           counterText: '',
//         ),
//       ),
//     );
//   }
// }

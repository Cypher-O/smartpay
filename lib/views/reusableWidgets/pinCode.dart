import 'package:smartpay/utilities/imports/generalImport.dart';

class PinCodeBox extends StatelessWidget {
  final SetPinViewModel viewModel;

  const PinCodeBox({
    Key? key,
    required this.viewModel,
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
      width: 48,
      child: TextFormField(
        obscuringCharacter: "●",
        obscureText: true,
        controller: viewModel.otpControllers[index],
        focusNode: viewModel.otpFocusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        maxLength: 1,
        autofocus: index == 0,
        onChanged: (value) {
          if (value.isNotEmpty && index < 4) {
            FocusScope.of(context)
                .requestFocus(viewModel.otpFocusNodes[index + 1]);
          }

          if (index == 4 && value.isNotEmpty) {
            FocusScope.of(context).unfocus();
          }
        },
        cursorColor: textOutline,
        decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.zero,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: textOutline),
          ),
        ),
      ),
    );
  }
}

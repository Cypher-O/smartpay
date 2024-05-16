import '../../../utilities/imports/generalImport.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
      viewModelBuilder: () => ForgotPasswordViewModel(),
      onViewModelReady: (model) async {},
      disposeViewModel: false,
      builder: (context, model, child) => BaseUi(
        children: [
          backButton(context),
          rowPositioned(
            top: 128,
            left: 30,
            right: 30,
            child: Stack(
              // alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: iconsContainer,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: iconsContainer,
                      width: 5,
                    ),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Image.asset(
                    "icons/password_recovery.png",
                    height: 40.0,
                    width: 40.0,
                  ),
                ),
                Positioned(
                  top: 0.0,
                  left: 55.0,
                  child: Image.asset(
                    "icons/password_recovery_highlight.png",
                    height: 20.0,
                    width: 20.0,
                  ),
                ),
              ],
            ),
          ),
          rowPositioned(
            top: 220,
            left: 16,
            child: GeneralTextDisplay("Password Recovery", AppColors.black(), 1,
                20, FontWeight.w700, ""),
          ),
          rowPositioned(
            top: 260,
            left: 16,
            child: Container(
              width: sS(context).w - 30,
              child: GeneralTextDisplay(
                  "Enter your registered email below to receive password instructions",
                  AppColors.gray3(),
                  2,
                  15,
                  FontWeight.w400,
                  ""),
            ),
          ),
          Positioned(
            top: sS(context).cH(height: 340),
            left: sS(context).cW(width: 16),
            bottom: sS(context).cH(height: 0),
            right: sS(context).cW(width: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     GeneralTextDisplay(
                  //       "Phone Number",
                  //       AppColors.black(),
                  //       1,
                  //       12,
                  //       FontWeight.w400,
                  //       "",
                  //       textAlign: TextAlign.left,
                  //     ),
                  //   ],
                  // ),
                  // S(h: 8),
                  // phone textfield
                  FormattedTextFields(
                    keyInputType: TextInputType.phone,
                    textFieldController: model.emailController,
                    textFieldHint: "abc@abc.com",
                    noBorder: true,
                    autoFocus: false,
                    inputFormatters: [LengthLimitingTextInputFormatter(11)],
                    onChangedFunction: () {
                      model.onChangedFunctionEmail();
                    },
                    errorTextActive: model.emailError,
                    focusNode: model.emailFocusNode,
                  ),
                  S(h: 12),
                  model.showErrorText(
                      text: model.emailController.text.isEmpty
                          ? 'Empty Field, enter email address'
                          : !isValidEmail(model.emailController.text.trim())
                              ? 'Invalid email, Please enter a valid email address'
                              : "",
                      errorBool: model.emailError),

                  S(h: 62),
                  buttonNoPositioned(
                    context,
                    text: 'Send me email',
                    radius: 16.0,
                    height: 60,
                    buttonColor: AppColors.blue(),
                    navigator: () {
                      context.goNamed(verifyIdentityRoute);
                      // model.getSecurityQuestion(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

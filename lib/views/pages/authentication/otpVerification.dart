import 'package:smartpay/utilities/imports/generalImport.dart';

class OtpVerification extends StatelessWidget {
  // String emailController;

  const OtpVerification({
    Key? key,
    // required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // debugPrint('Received Email in OTP Page: $emailController');
    return ViewModelBuilder<OtpLoginViewModel>.reactive(
      viewModelBuilder: () => OtpLoginViewModel(),
      // OtpLoginViewModel(emailController: emailController),
      onViewModelReady: (model) async {},
      disposeViewModel: false,
      builder: (context, model, child) => BaseUi(
        children: [
          backButton(context, navigateTo: signupRoute),
          rowPositioned(
            top: 128,
            left: 16,
            child: GeneralTextDisplay(
              "Verify it's you",
              AppColors.black(),
              1,
              20,
              FontWeight.bold,
              "",
            ),
          ),
          rowPositioned(
            top: 170,
            left: 16,
            child: Container(
              width: sS(context).w - 30,
              child: GeneralTextDisplay(
                "We sent a code to (*****@gmail.com). Enter it here to verify your identity",
                AppColors.gray3(),
                2,
                15,
                FontWeight.w400,
                "",
              ),
            ),
          ),
          Positioned(
            top: sS(context).cH(height: 250),
            left: sS(context).cW(width: 16),
            bottom: sS(context).cH(height: 0),
            right: sS(context).cW(width: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  OtpInputBox(
                    viewModel: model,
                    onKeyPressed: (value) {
                      model.updateOtpInput(context, value);
                    },
                  ),
                  S(h: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: GeneralTextDisplay(
                          'Resend code (00:30)',
                          AppColors.gray3(),
                          1,
                          16,
                          FontWeight.w600,
                          'Resend code',
                          textAlign: TextAlign.center,
                        ),
                        onTap: () async {
                          // Clear the otpControllers
                          model.otpControllers
                              .forEach((controller) => controller.clear());
                        },
                      ),
                    ],
                  ),
                  S(h: 80),
                  ButtonWidget(
                    () {
                      // if (model.emailFunctionSatisfied) {
                      context.goNamed(signupFormRoute);
                      // }
                    },
                    blueDark,
                    // AppColors.blue(),
                    382,
                    60,
                    Text(
                      "Confirm",
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.white(),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Alignment.center,
                    20,
                    noElevation: 0,
                  ),
                  Container(
                    width: sS(context).w - 16,
                    height: sS(context).h - 550,
                    child: CustomKeyboard(
                      onKeyPressed: (value) {
                        debugPrint("Pressed: $value");
                        // Handle erase button press
                        model.updateOtpInput(context, value);
                      },
                    ),
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

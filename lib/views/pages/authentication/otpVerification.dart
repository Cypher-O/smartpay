import 'package:smartpay/utilities/imports/generalImport.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpLoginViewModel>.reactive(
      viewModelBuilder: () => OtpLoginViewModel(),
      onViewModelReady: (model) async {
        maskedEmail = model.maskEmail(newUserEmailBucket!);
        model.startCountdown(model.countdownDuration);
        model.sendEmailOtp(context);
      },
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
                "We sent a code to $maskedEmail. Enter it here to verify your identity",
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
                          // 'Resend code (00:30)',
                          model.isCountdownActive
                              ? 'Resend code (${model.countdownDisplay})'
                              : 'Resend code',
                          AppColors.gray3(),
                          1,
                          16,
                          FontWeight.w600,
                          'Resend code',
                          textAlign: TextAlign.center,
                        ),
                        onTap: () async {
                          if (!model.isCountdownActive) {
                            model.startCountdown(model.countdownDuration);

                            model.sendEmailOtp(context);
                          }
                        },
                      ),
                    ],
                  ),
                  S(h: 80),
                  ButtonWidget(
                    () {
                      model.verifyEmailOtp(context);
                    },
                    model.areAllBoxesFilled() ? blueDark : disabledButton,
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
                    height: sS(context).h - 500,
                    child: CustomKeyboard(
                      onDeletePressed: () {
                        model.updateOtpInput(context, 'delete');
                      },
                      onKeyPressed: (value) {
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

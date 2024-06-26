import 'package:smartpay/utilities/imports/generalImport.dart';

class SetPinCode extends StatelessWidget {
  const SetPinCode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetPinViewModel>.reactive(
      viewModelBuilder: () => SetPinViewModel(),
      onViewModelReady: (model) async {},
      disposeViewModel: false,
      builder: (context, model, child) => BaseUi(
        children: [
          backButton(context, navigateTo: signupFormRoute),
          rowPositioned(
            top: 128,
            left: 16,
            child: GeneralTextDisplay(
              "Set your PIN code",
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
                "We use state-of-the-art security measures to protect your information at all times",
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
                  PinCodeBox(
                    viewModel: model,
                    // onKeyPressed: (value) {
                    //   model.updateOtpInput(context, value);
                    // },
                  ),
                  S(h: 40),
                  S(h: 80),
                  ButtonWidget(
                    () {
                      model.showSuccessScreen(
                        context,
                        "assets/icons/thumbs-up.png",
                        "Congratulations, James",
                        "You've completed the onboarding, you can start using",
                        "Get Started",
                        () {
                          // context.pop(context);
                          context.goNamed(homeRoute);
                        },
                      );
                    },
                    blueDark,
                    382,
                    60,
                    Text(
                      "Create PIN",
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

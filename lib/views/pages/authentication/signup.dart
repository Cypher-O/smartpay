import 'package:smartpay/utilities/imports/generalImport.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
      viewModelBuilder: () => SignupViewModel(),
      onViewModelReady: (model) async {},
      disposeViewModel: false,
      builder: (context, model, child) {
        return PopScope(
          canPop: false,
          child: BaseUi(
            children: [
              backButton(context, navigateTo: onboardingRoute),
              rowPositioned(
                top: 128,
                left: 16,
                child: Container(
                  width: sS(context).w - 150,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    //  mainAxisSize: MainAxisSize.min,
                    children: [
                      GeneralTextDisplay("Create a ", AppColors.black(), 1, 20,
                          FontWeight.bold, ""),
                      GeneralTextDisplay(
                        "Smartpay ",
                        blueLight,
                        1,
                        20,
                        FontWeight.bold,
                        "",
                        decorationColor: blueLight,
                      ),
                      GeneralTextDisplay("account", AppColors.black(), 1, 20,
                          FontWeight.bold, ""),
                    ],
                  ),
                ),
              ),
              rowPositioned(
                left: 16,
                right: 16,
                top: 200,
                child: Expanded(
                  child: SizedBox(
                    height: ScreenSize(context: context).cH(height: 700),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          S(h: 10),
                          FormattedTextFields(
                            keyInputType: TextInputType.emailAddress,
                            textFieldController: model.emailController,
                            textFieldHint: "Email",
                            noBorder: true,
                            autoFocus: false,
                            inputFormatters: const [],
                            onChangedFunction: () {
                              model.onChangedFunctionEmail(context);
                            },
                            errorTextActive: model.emailError,
                            focusNode: model.emailFocusNode,
                          ),
                          S(h: 10),
                          model.showErrorText(
                              text: model.emailController.text.isEmpty
                                  ? 'Empty Field, enter email address'
                                  : !isValidEmail(
                                          model.emailController.text.trim())
                                      ? 'Invalid email, Please enter a valid email address'
                                      : "",
                              errorBool: model.emailError),

                          S(h: 25),

                          ButtonWidget(
                            () {
                              if (model.emailFunctionSatisfied) {
                                model.validateAndNavigate(context);
                              }
                            },
                            model.emailFunctionSatisfied
                                ? blueDark
                                : disabledButton,
                            // AppColors.blue(),
                            382,
                            60,
                            Text(
                              "Sign Up",
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
                          S(h: 25),
                          // or continue with
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: 1.2,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    'OR',
                                    style: TextStyle(color: AppColors.grey()),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 1.2,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          S(h: 30),
                          // google + apple sign in buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              // google button
                              RectangularTile(
                                  imagePath: 'assets/images/google.png'),

                              SizedBox(width: 15),

                              // apple button
                              RectangularTile(
                                  imagePath: 'assets/images/apple.png'),
                            ],
                          ),
                          S(h: 30),
                          Container(
                            width: sS(context).w - 30,
                            height: sS(context).h - 600,
                            alignment: Alignment.center,
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              //  mainAxisSize: MainAxisSize.min,
                              children: [
                                GeneralTextDisplay(
                                    "Already have an account? ",
                                    AppColors.gray3(),
                                    1,
                                    14,
                                    FontWeight.w400,
                                    ""),
                                GestureDetector(
                                  onTap: () {
                                    context.goNamed(loginRoute);
                                  },
                                  child: GeneralTextDisplay(
                                    "Sign In",
                                    blueLight,
                                    1,
                                    14,
                                    FontWeight.w800,
                                    "",
                                    decorationColor: blueLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

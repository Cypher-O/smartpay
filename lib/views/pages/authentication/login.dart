import 'package:smartpay/utilities/imports/generalImport.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onViewModelReady: (model) async {},
      disposeViewModel: false,
      builder: (context, model, child) {
        return PopScope(
          canPop: false,
          child: BaseUi(
            children: [
              backButton(context, navigateTo: onboardingRoute),
              rowPositioned(
                top: 120,
                left: 16,
                child: GeneralTextDisplay(
                  "Hi There! 👋",
                  AppColors.black(),
                  1,
                  20,
                  FontWeight.bold,
                  "",
                ),
              ),
              rowPositioned(
                top: 160,
                left: 16,
                child: GeneralTextDisplay(
                  "Welcome back, Sign in to your account",
                  AppColors.black(),
                  1,
                  16,
                  FontWeight.w400,
                  "",
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

                          S(h: 10),
                          FormattedTextFields(
                            keyInputType: TextInputType.text,
                            textFieldController: model.passwordController,
                            textFieldHint: "Password",
                            noBorder: true,
                            autoFocus: false,
                            obscureText: model.obscureText,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                model.obscureTextFunction();
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GeneralIconDisplay(
                                    model.obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    AppColors.grey(),
                                    UniqueKey(),
                                    20,
                                  ),
                                ],
                              ),
                            ),
                            inputFormatters: const [],
                            onChangedFunction: () {
                              model.onChangedFunctionPassword();
                            },
                            errorTextActive: model.passwordError,
                            focusNode: model.passwordFocusNode,
                          ),
                          S(h: 12),
                          model.showErrorText(
                              lineLength: 2,
                              text: model.passwordController.text.isEmpty
                                  ? 'Empty Field, enter password!'
                                  : !isValidPassword(
                                          model.passwordController.text.trim())
                                      ? 'Invalid password, Length must be more than 7 and contains lower case, upper case , digit and  symbol'
                                      : "",
                              errorBool: model.passwordError),
                          S(h: 25),
                          Container(
                            width: sS(context).w - 30,
                            alignment: Alignment.centerLeft,
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              //  mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.goNamed(forgotPasswordRoute);
                                  },
                                  child: GeneralTextDisplay(
                                    "Forgot password?",
                                    blueLight,
                                    1,
                                    14,
                                    FontWeight.w800,
                                    "",
                                    decorationColor: blueLight,
                                  ),
                                )
                              ],
                            ),
                          ),
                          S(h: 25),
                          ButtonWidget(
                            () {
                              // model.login(context);
                              // context.goNamed(homeRoute);
                            },
                            AppColors.blue(),
                            338,
                            60,
                            Text(
                              "Sign In",
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
                              RectangularTile(imagePath: 'images/google.png'),

                              SizedBox(width: 15),

                              // apple button
                              RectangularTile(imagePath: 'images/apple.png')
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
                                    "Don’t have an account? ",
                                    AppColors.gray3(),
                                    1,
                                    14,
                                    FontWeight.w400,
                                    ""),
                                InkWell(
                                  onTap: () {
                                    context.goNamed(signupRoute);
                                  },
                                  child: GeneralTextDisplay(
                                    "Sign Up",
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

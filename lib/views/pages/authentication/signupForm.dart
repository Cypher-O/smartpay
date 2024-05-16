import 'package:smartpay/utilities/imports/generalImport.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupFormViewModel>.reactive(
      viewModelBuilder: () => SignupFormViewModel(),
      onViewModelReady: (model) async {},
      disposeViewModel: false,
      builder: (context, model, child) {
        return PopScope(
          canPop: false,
          child: BaseUi(
            children: [
              backButton(context, navigateTo: otpVerificationRoute),
              rowPositioned(
                top: 128,
                left: 16,
                child: Container(
                  width: sS(context).w - 128,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    //  mainAxisSize: MainAxisSize.min,
                    children: [
                      GeneralTextDisplay("Hey there! tell us a bit about ",
                          AppColors.black(), 2, 20, FontWeight.bold, ""),
                      GeneralTextDisplay(
                        "yourself ",
                        blueLight,
                        1,
                        20,
                        FontWeight.bold,
                        "",
                        decorationColor: blueLight,
                      ),
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
                            textFieldController: model.fullNameController,
                            textFieldHint: "Full name",
                            noBorder: true,
                            autoFocus: false,
                            inputFormatters: const [],
                            onChangedFunction: () {
                              model.onChangedFunctionFullName(context);
                            },
                            errorTextActive: model.fullNameError,
                            focusNode: model.fullNameFocusNode,
                          ),
                          S(h: 10),
                          model.showErrorText(
                              text: model.fullNameController.text.isEmpty
                                  ? 'Value must not be empty '
                                  : "",
                              errorBool: model.fullNameError),
                          S(h: 10),
                          FormattedTextFields(
                            keyInputType: TextInputType.emailAddress,
                            textFieldController: model.userNameController,
                            textFieldHint: "Username",
                            noBorder: true,
                            autoFocus: false,
                            inputFormatters: const [],
                            onChangedFunction: () {
                              model.onChangedFunctionEmail(context);
                            },
                            errorTextActive: model.userNameError,
                            focusNode: model.userNameFocusNode,
                          ),
                          S(h: 10),
                          model.showErrorText(
                              text: model.userNameController.text.isEmpty
                                  ? 'Empty Field, enter email address'
                                  : !isValidEmail(
                                          model.userNameController.text.trim())
                                      ? 'Invalid email, Please enter a valid email address'
                                      : "",
                              errorBool: model.userNameError),
                          S(h: 10),
                          dropdownFieldWidget(
                            context,
                            items: ["test", "test", "test"],
                            hintText: "Select Country",
                            callback: (value) {},
                          ),
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
                          ButtonWidget(
                            () {
                              // model.login(context);
                              context.goNamed(setPinCodeRoute);
                            },
                            AppColors.blue(),
                            382,
                            60,
                            Text(
                              "Continue",
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

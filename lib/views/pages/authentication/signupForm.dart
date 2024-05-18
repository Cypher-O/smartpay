import 'package:smartpay/utilities/imports/generalImport.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupFormViewModel>.reactive(
      viewModelBuilder: () => SignupFormViewModel(),
      onViewModelReady: (model) async {
        model.getCountries(context);
      },
      disposeViewModel: false,
      builder: (context, model, child) {
        return PopScope(
          canPop: false,
          child: BaseUi(
            refreshedEnabled: false,
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
                                  ? 'Full name must not be empty '
                                  : model.fullNameController.text.length < 5
                                      ? "Full name must not be less than 5"
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
                              model.onChangedFunctionUserName(context);
                            },
                            errorTextActive: model.userNameError,
                            focusNode: model.userNameFocusNode,
                          ),
                          S(h: 10),
                          model.showErrorText(
                              text: model.userNameController.text.isEmpty
                                  ? 'Username must not be empty '
                                  : model.userNameController.text.length < 5
                                      ? "Username must not be less than 5"
                                      : "",
                              errorBool: model.userNameError),
                          S(h: 10),
                          CountryPicker(
                            onSelect: (Countries selectedCountry) {
                              debugPrint(
                                  'Selected Country: ${selectedCountry.countryName}');
                            },
                            countries: model.countriesList,
                            // errorTextActive: model.selectedCountryError,
                          ),
                          S(h: 8),
                          // model.showErrorText(
                          //     text: "Please select a country",
                          //     errorBool: model.selectedCountryError),
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
                          S(h: 10),
                          FormattedTextFields(
                            keyInputType: TextInputType.text,
                            textFieldController:
                                model.confirmPasswordController,
                            textFieldHint: "Confirm Password",
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
                              model.onChangedFunctionConfirmPassword();
                            },
                            errorTextActive: model.confirmPasswordError,
                            focusNode: model.confirmPasswordFocusNode,
                          ),
                          S(h: 12),
                          model.showErrorText(
                              lineLength: 2,
                              text: model.confirmPasswordController.text.isEmpty
                                  ? 'Empty Field, enter password!'
                                  : !isValidPassword(model
                                          .confirmPasswordController.text
                                          .trim())
                                      ? 'Invalid password, Length must be more than 7 and contains lower case, upper case , digit and  symbol'
                                      : (model.passwordController.text.trim() !=
                                              model.confirmPasswordController
                                                  .text
                                                  .trim())
                                          ? "Passwords do not match"
                                          : "",
                              errorBool: model.passwordError),
                          S(h: 25),
                          ButtonWidget(
                            () {
                              model.createAccount(context);
                              // context.goNamed(setPinCodeRoute);
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

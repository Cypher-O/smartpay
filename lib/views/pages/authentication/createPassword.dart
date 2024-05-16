import '../../../utilities/imports/generalImport.dart';

class CreatePassword extends StatelessWidget {
  const CreatePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreatePasswordViewModel>.reactive(
      viewModelBuilder: () => CreatePasswordViewModel(),
      onViewModelReady: (model) async {},
      disposeViewModel: false,
      builder: (context, model, child) => BaseUi(
        children: [
          backButton(context, navigateTo: verifyIdentityRoute),
          rowPositioned(
            top: 130,
            left: 16,
            child: GeneralTextDisplay("Create New Password", AppColors.black(),
                1, 20, FontWeight.w700, ""),
          ),
          rowPositioned(
            top: 180,
            left: 16,
            child: Container(
              width: sS(context).w - 30,
              child: GeneralTextDisplay(
                  "Please, enter a new password below different from the previous password",
                  AppColors.gray3(),
                  2,
                  15,
                  FontWeight.w400,
                  ""),
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
                  FormattedTextFields(
                    keyInputType: TextInputType.text,
                    textFieldController: model.confirmPasswordController,
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
                      model.onChangedFunctionPassword();
                    },
                    errorTextActive: model.confirmPasswordError,
                    focusNode: model.confirmPasswordFocusNode,
                  ),
                  S(h: 12),
                  model.showErrorText(
                      lineLength: 2,
                      text: model.confirmPasswordController.text.isEmpty
                          ? 'Empty Field, enter password!'
                          : !isValidPassword(
                                  model.confirmPasswordController.text.trim())
                              ? 'Invalid password, Length must be more than 7 and contains lower case, upper case , digit and  symbol'
                              : (model.passwordController.text.trim() ==
                                      model.passwordController.text.trim())
                                  ? "Passwords do not match"
                                  : "",
                      errorBool: model.confirmPasswordError),
                  S(h: 25),
                  S(h: 24),
                ],
              ),
            ),
          ),
          rowPositioned(
            top: 730,
            child: ButtonWidget(
              () async {
                context.goNamed(createPasswordRoute);
              },
              AppColors.blue(),
              328,
              60,
              Text(
                "Create new password",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.white(),
                  fontWeight: FontWeight.w800,
                ),
              ),
              Alignment.center,
              20,
              noElevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}

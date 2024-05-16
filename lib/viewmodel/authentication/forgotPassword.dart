import '../../utilities/imports/generalImport.dart';

class ForgotPasswordViewModel extends BaseModel {
  final emailController = TextEditingController();

  bool emailError = false;

  // focus node
  FocusNode emailFocusNode = FocusNode();

  // change email function
  onChangedFunctionEmail() {
    emailFocusNode.addListener(() {
      if (emailFocusNode.hasFocus == false) {
        emailError = false;
        notifyListeners();
      }
    });
    if (isValidEmail(emailController.text.trim())) {
      emailError = false;
      notifyListeners();
    } else {
      emailError = true;
      notifyListeners();
    }
  }

  Future<bool> _validateForm() async {
    if (isValidEmail(emailController.text.trim())) {
      emailError = true;
      notifyListeners();
      emailFocusNode.requestFocus();
      return false;
    } else {
      return true;
    }
  }

  // //Service Implementation
  // Future<void> getSecurityQuestion(BuildContext context) async {
  //   bool validated = await _validateForm();

  //   if (validated) {
  //     securityphoneNumberBucket = null;
  //     securityQuestionBucket = null;
  //     runFunctionForApi(context, functionToRunAfterService: (value) async {
  //       if (value is GetSecurityQuestionModel) {
  //         if (value.code == 0) {
  //           securityphoneNumberBucket =
  //               formatPhoneNumber(phoneController.text.trim());
  //           securityQuestionBucket = value.data!['question'];
  //           context.pushNamed(securityQuestionRoute);
  //         }
  //       } else {
  //         loaderWithClose(context, text: formatErrorMessage(value['message']));
  //       }
  //     },
  //         functionToRunService: getSecurityQuestionService(
  //             formatPhoneNumber(phoneController.text.trim())));
  //   }
  // }
}

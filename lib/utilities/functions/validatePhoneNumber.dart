// class to validate phone number

import '../imports/generalImport.dart';

class ValidatePhoneNumber {
  // function to validate phone number with +234
  static bool isValidNumber(String input) {
    final RegExp regex = RegExp(r'^(?:[+]13)?[0-9]{14}$');
    regex.hasMatch(input)
        ? debugPrint("$input validated")
        : debugPrint("$input invalidated");
    return regex.hasMatch(input);
  }
  // function to validate phone number

  bool isValidPhone(String input) {
    // for phone number of length 10
    final RegExp regex = RegExp(r'^[0][7|8|9][0|1]\d{7}$');
    // for phone number of length 11
    final RegExp regex2 = RegExp(r'^[0][7|8|9][0|1]\d{8}$');
    // regex.hasMatch(input)?debugPrint("$input validated"):debugPrint("$input invalidated");
    // return regex.hasMatch(input) || regex2.hasMatch(input);
    return regex2.hasMatch(input);
  }
}

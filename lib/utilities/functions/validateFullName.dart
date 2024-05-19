bool isValidFullName(String value) {
  // Ensure the full name contains at least one space and does not start with a space.
  String pattern = r'^[^\s].*\s.*$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

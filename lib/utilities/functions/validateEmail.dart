// this class is to validate email address
bool isValidEmail(String input) {
  final RegExp regex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9]{2,})$"); // Updated regex pattern
  return regex.hasMatch(input);
}


bool isValidWorkEmail(String email) {
  final RegExp regex = RegExp(
    r"^(?!.*@(gmail\.|hotmail\.|icloud\.|yahoo\.)).*[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
  );
  return regex.hasMatch(email);
}

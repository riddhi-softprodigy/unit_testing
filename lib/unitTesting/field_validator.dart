import 'dart:convert';

class FieldValidator {
  static String validateEmail(String value) {
    if (value.isEmpty) return "Enter Email";

    Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return "Enter valid Email";
    }

    return null;
  }

  static String validatePassword(String value) {
    if (value.isEmpty) return "Enter Password";

    if (value.length < 7) {
      return "Password must be more than 6 charater";
    }

    return null;
  }
}

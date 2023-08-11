import 'package:formz/formz.dart';

enum PasswordValidationError { empty, invalid, regExpNotMatch }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String value) {
    String _password = value.trim();
    if (_password.isEmpty) {
      return PasswordValidationError.empty;
    } else if (_password.length < 6) {
      return PasswordValidationError.invalid;
    } else {
      return null;
    }
  }

  static String? showPasswordErrorMessage(PasswordValidationError? error) {
    if (error == PasswordValidationError.empty) {
      return 'Empty password';
    } else if (error == PasswordValidationError.invalid) {
      return "Password must be at least 6 characters";
    } else if (error == PasswordValidationError.regExpNotMatch) {
      return " Password should contain Capital, small letter \n Number & Special";
    } else {
      return null;
    }
  }
}

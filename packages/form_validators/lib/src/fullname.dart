import 'package:formz/formz.dart';

enum FullNameValidationError { empty, invalid }

class FullName extends FormzInput<String, FullNameValidationError> {
  const FullName.pure() : super.pure('');
  const FullName.dirty([String value = '']) : super.dirty(value);

  @override
  FullNameValidationError? validator(String value) {
    if (value.isEmpty) {
      return FullNameValidationError.empty;
    } else if (value.length <= 3) {
      return FullNameValidationError.invalid;
    } else {
      return null;
    }
  }

  static String? showNameErrorMessage(FullNameValidationError? error) {
    if (error == FullNameValidationError.empty) {
      return 'Empty name';
    } else if (error == FullNameValidationError.invalid) {
      return 'Too short name';
    } else {
      return null;
    }
  }
}

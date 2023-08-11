import 'dart:developer';

import 'package:formz/formz.dart';

enum PhoneNumberValidationError {
  empty,
  lengthInvalid,
  lengthMoreInvalid,
  invalid,
  zeroLeadingInvalid,
}

class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumber.pure() : super.pure('');
  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  @override
  PhoneNumberValidationError? validator(String value) {
    //nomer tanpa angka 0 depanya
    //jadi min 10 digit dan 11 digit

    RegExp numberValid = RegExp(r'([0-9]{10}$)');
    String _num = value.trim();
    if (_num.length == 10 && _num.length == 11) {
      return null;
    }
    if (_num.isEmpty) {
      return PhoneNumberValidationError.empty;
    } else if (_num.startsWith('0')) {
      return PhoneNumberValidationError.zeroLeadingInvalid;
    } else if (_num.length < 10) {
      return PhoneNumberValidationError.lengthInvalid;
    } else if (_num.length > 11) {
      return PhoneNumberValidationError.lengthMoreInvalid;
    } else if (!numberValid.hasMatch(_num)) {
      return PhoneNumberValidationError.invalid;
    } else {
      return null;
    }
  }

  static String? showPhoneNumberErrorMessage(
      PhoneNumberValidationError? error) {
    log(error.toString(), name: 'PhoneNumberValidationError');
    if (error == PhoneNumberValidationError.empty) {
      return 'Nomer seluler tidak boleh kosong';
    } else if (error == PhoneNumberValidationError.lengthInvalid) {
      return "Gunakan format ini: 813 8966 8688";
    } else if (error == PhoneNumberValidationError.lengthMoreInvalid) {
      return "Nomor seluler tidak boleh lebih dari 11 digit";
    } else if (error == PhoneNumberValidationError.invalid) {
      return "Masukan nomer yang valid";
    } else if (error == PhoneNumberValidationError.zeroLeadingInvalid) {
      return "Tidak boleh diawali angka 0";
    } else {
      return null;
    }
  }
}

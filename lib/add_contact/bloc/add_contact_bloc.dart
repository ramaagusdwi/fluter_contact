import 'package:contacts_repository/contacts_repository.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_contact_event.dart';
part 'add_contact_state.dart';

class AddContactBloc extends Bloc<AddContactEvent, AddContactState> {
  AddContactBloc({
    required ContactsRepository contactsRepository,
  })  : _contactsRepository = contactsRepository,
        super(
          const AddContactState(
            firstName: '',
            lastName: '',
          ),
        ) {
    on<AddContactFirstNameChanged>(_onFirstNameChanged);
    on<AddContactLastNameChanged>(_onLastNameChanged);
    on<AddContactEmailChanged>(_onEmailChanged);
    on<AddContactPhoneChanged>(_onPhoneChanged);
    on<AddContactSubmitted>(_onSubmitted);
  }

  final ContactsRepository _contactsRepository;

  void _onFirstNameChanged(
    AddContactFirstNameChanged event,
    Emitter<AddContactState> emit,
  ) {
    emit(state.copyWith(
        firstName: event.firstName,
        status: event.firstName.isNotEmpty
            ? AddContactStatus.initial
            : AddContactStatus.failure));
  }

  void _onLastNameChanged(
    AddContactLastNameChanged event,
    Emitter<AddContactState> emit,
  ) {
    emit(state.copyWith(lastName: event.lastName));
  }

  void _onPhoneChanged(
    AddContactPhoneChanged event,
    Emitter<AddContactState> emit,
  ) {
    emit(state.copyWith(
        phone: event.phone,
        firstName: state.firstName,
        status: event.phone.isNotEmpty
            ? AddContactStatus.initial
            : AddContactStatus.failure));
  }

  void _onEmailChanged(
    AddContactEmailChanged event,
    Emitter<AddContactState> emit,
  ) {
    emit(state.copyWith(
        email: event.email,
        firstName: state.firstName,
        phone: state.phone,
        status: event.email.isNotEmpty
            ? AddContactStatus.initial
            : AddContactStatus.failure));
  }

  Future<void> _onSubmitted(
    AddContactSubmitted event,
    Emitter<AddContactState> emit,
  ) async {
    if (state.firstName.isEmpty) {
      emit(state.copyWith(
          status: AddContactStatus.failure,
          errorMessage: 'Nama depan harus diisi!'));
      return;
    }

    if (state.phone.isEmpty) {
      emit(state.copyWith(
          status: AddContactStatus.failure,
          errorMessage: 'Telpon harus diisi!'));
      return;
    }

    if (state.phone.isNotEmpty && state.phone.length < 12) {
      emit(state.copyWith(
          status: AddContactStatus.failure,
          errorMessage: 'Telpon minimal 12 digit!'));
      return;
    }

    if (state.email.isEmpty) {
      emit(state.copyWith(
          status: AddContactStatus.failure,
          errorMessage: 'Email  harus diisi!'));
      return;
    }

    if (state.email.isNotEmpty && !EmailValidator.validate(state.email)) {
      emit(state.copyWith(
          status: AddContactStatus.failure,
          errorMessage: 'Email tidak valid!'));
      return;
    }

    if (state.email.isNotEmpty &&
        state.phone.isNotEmpty &&
        state.firstName.isNotEmpty) {
      emit(state.copyWith(status: AddContactStatus.loading));
      final contactState = state.copyWith(
        firstName: state.firstName,
        lastName: state.lastName,
      );

      try {
        await _contactsRepository.saveContactModel(ContactModel(
            title: contactState.firstName, description: contactState.lastName));
        emit(state.copyWith(status: AddContactStatus.success));
      } catch (e) {
        emit(state.copyWith(
            status: AddContactStatus.failure,
            errorMessage: 'Gagal tambah kontak!'));
      }
    }
  }
}

import 'package:contacts_repository/contacts_repository.dart';
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
    on<AddContactTitleChanged>(_onTitleChanged);
    on<AddContactDescriptionChanged>(_onDescriptionChanged);
    on<AddContactSubmitted>(_onSubmitted);
  }

  final ContactsRepository _contactsRepository;

  void _onTitleChanged(
    AddContactTitleChanged event,
    Emitter<AddContactState> emit,
  ) {
    emit(state.copyWith(firstName: event.title));
  }

  void _onDescriptionChanged(
    AddContactDescriptionChanged event,
    Emitter<AddContactState> emit,
  ) {
    emit(state.copyWith(lastName: event.description));
  }

  Future<void> _onSubmitted(
    AddContactSubmitted event,
    Emitter<AddContactState> emit,
  ) async {
    if (state.email.isEmpty || state.phone.isEmpty) {
      emit(state.copyWith(
          status: AddContactStatus.failure,
          errorMessage: 'Email atau telpon harus diisi!'));
      // return;
    }

    if (state.email.isNotEmpty && state.phone.isNotEmpty) {
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

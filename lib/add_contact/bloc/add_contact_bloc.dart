import 'package:bloc/bloc.dart';
import 'package:contacts_repository/contacts_repository.dart';
import 'package:equatable/equatable.dart';

part 'add_contact_event.dart';
part 'add_contact_state.dart';

class AddContactBloc extends Bloc<AddContactEvent, AddContactState> {
  AddContactBloc({
    required ContactsRepository contactsRepository,
  })  : _contactsRepository = contactsRepository,
        super(
          const AddContactState(
            title: '',
            description: '',
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
    emit(state.copyWith(title: event.title));
  }

  void _onDescriptionChanged(
    AddContactDescriptionChanged event,
    Emitter<AddContactState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _onSubmitted(
    AddContactSubmitted event,
    Emitter<AddContactState> emit,
  ) async {
    emit(state.copyWith(status: AddContactStatus.loading));
    final contactState = state.copyWith(
      title: state.title,
      description: state.description,
    );

    try {
      await _contactsRepository.saveContactModel(ContactModel(
          title: contactState.title, description: contactState.description));
      emit(state.copyWith(status: AddContactStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AddContactStatus.failure));
    }
  }
}

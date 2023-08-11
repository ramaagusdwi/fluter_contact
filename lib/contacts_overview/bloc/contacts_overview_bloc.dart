import 'package:bloc/bloc.dart';
import 'package:contacts_repository/contacts_repository.dart';
import 'package:equatable/equatable.dart';

part 'contacts_overview_event.dart';
part 'contacts_overview_state.dart';

class ContactsOverviewBloc
    extends Bloc<ContactsOverviewEvent, ContactsOverviewState> {
  ContactsOverviewBloc({
    required ContactsRepository contactsRepository,
  })  : _contactsRepository = contactsRepository,
        super(const ContactsOverviewState()) {
    on<ContactsOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<ContactsOverviewContactCreated>(_onContactCreated);
    on<ContactsOverviewContactFavoriteToggled>(_onContactFavoritedToggled);
  }

  final ContactsRepository _contactsRepository;

  Future<void> _onSubscriptionRequested(
    ContactsOverviewSubscriptionRequested event,
    Emitter<ContactsOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => ContactsOverviewStatus.loading));

    await emit.forEach<List<ContactModel>>(
      _contactsRepository.getContacts(),
      onData: (todos) => state.copyWith(
        status: () => ContactsOverviewStatus.success,
        todos: () => todos,
      ),
      onError: (_, __) => state.copyWith(
        status: () => ContactsOverviewStatus.failure,
      ),
    );
  }

  Future<void> _onContactFavoritedToggled(
    ContactsOverviewContactFavoriteToggled event,
    Emitter<ContactsOverviewState> emit,
  ) async {
    // final newTodo = event.todo.copyWith(isCompleted: event.isCompleted);
    await _contactsRepository.favoriteContact(id: event.contact.id);
  }

  Future<void> _onContactCreated(
    ContactsOverviewContactCreated event,
    Emitter<ContactsOverviewState> emit,
  ) async {
    // final newTodo = event.todo.copyWith(isCompleted: event.isCompleted);
    await _contactsRepository.saveContactModel(event.contact);
  }
}

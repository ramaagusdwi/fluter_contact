import 'package:bloc/bloc.dart';
import 'package:contacts_repository/contacts_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'detail_contact_event.dart';
part 'detail_contact_state.dart';

class DetailContactBloc extends Bloc<DetailContactEvent, DetailContactState> {
  DetailContactBloc({
    required ContactsRepository contactsRepository,
  })  : _contactsRepository = contactsRepository,
        super(const DetailContactState()) {
    on<DetailContactRequest>(_onSubscriptionRequested);
  }

  final ContactsRepository _contactsRepository;

  Future<void> _onSubscriptionRequested(
    DetailContactRequest event,
    Emitter<DetailContactState> emit,
  ) async {
    // emit(state.copyWith(status: () => DetailContactStatus.loading));
    final contact = _contactsRepository.getContact(id: event.id);
    debugPrint('firstName: ${contact.firstName}');
    emit(state.copyWith(
      status: () => DetailContactStatus.success,
      firstName: contact.firstName,
      lastName: contact.lastName,
      email: contact.email,
      phone: contact.phone,
    ));
  }
}

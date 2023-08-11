part of 'contacts_overview_bloc.dart';

enum ContactsOverviewStatus { initial, loading, success, failure }

final class ContactsOverviewState extends Equatable {
  const ContactsOverviewState({
    this.status = ContactsOverviewStatus.initial,
    this.contacts = const [],
  });

  final ContactsOverviewStatus status;
  final List<ContactModel> contacts;

  ContactsOverviewState copyWith({
    ContactsOverviewStatus Function()? status,
    List<ContactModel> Function()? contacts,
  }) {
    return ContactsOverviewState(
      status: status != null ? status() : this.status,
      contacts: contacts != null ? contacts() : this.contacts,
    );
  }

  @override
  List<Object?> get props => [
        status,
        contacts,
      ];
}

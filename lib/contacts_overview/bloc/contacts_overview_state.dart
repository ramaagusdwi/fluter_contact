part of 'contacts_overview_bloc.dart';

enum ContactsOverviewStatus { initial, loading, success, failure }

final class ContactsOverviewState extends Equatable {
  const ContactsOverviewState({
    this.status = ContactsOverviewStatus.initial,
    this.todos = const [],
  });

  final ContactsOverviewStatus status;
  final List<ContactModel> todos;

  ContactsOverviewState copyWith({
    ContactsOverviewStatus Function()? status,
    List<ContactModel> Function()? todos,
  }) {
    return ContactsOverviewState(
      status: status != null ? status() : this.status,
      todos: todos != null ? todos() : this.todos,
    );
  }

  @override
  List<Object?> get props => [
        status,
        todos,
      ];
}

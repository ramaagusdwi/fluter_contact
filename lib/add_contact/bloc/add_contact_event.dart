part of 'add_contact_bloc.dart';

sealed class AddContactEvent extends Equatable {
  const AddContactEvent();

  @override
  List<Object> get props => [];
}

final class AddContactTitleChanged extends AddContactEvent {
  const AddContactTitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

final class AddContactDescriptionChanged extends AddContactEvent {
  const AddContactDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

final class AddContactSubmitted extends AddContactEvent {
  const AddContactSubmitted();
}

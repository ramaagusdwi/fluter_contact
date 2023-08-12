part of 'add_contact_bloc.dart';

sealed class AddContactEvent extends Equatable {
  const AddContactEvent();

  @override
  List<Object> get props => [];
}

final class AddContactFirstNameChanged extends AddContactEvent {
  const AddContactFirstNameChanged(this.firstName);

  final String firstName;

  @override
  List<Object> get props => [firstName];
}

final class AddContactLastNameChanged extends AddContactEvent {
  const AddContactLastNameChanged(this.lastName);

  final String lastName;

  @override
  List<Object> get props => [lastName];
}

final class AddContactWorkChanged extends AddContactEvent {
  const AddContactWorkChanged(this.work);

  final String work;

  @override
  List<Object> get props => [work];
}

final class AddContactPhoneChanged extends AddContactEvent {
  const AddContactPhoneChanged(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

final class AddContactEmailChanged extends AddContactEvent {
  const AddContactEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class AddContactWebsiteChanged extends AddContactEvent {
  const AddContactWebsiteChanged(this.website);

  final String website;

  @override
  List<Object> get props => [website];
}

final class AddContactSubmitted extends AddContactEvent {
  const AddContactSubmitted();
}

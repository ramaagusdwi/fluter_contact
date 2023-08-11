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
  const AddContactEmailChanged(this.contact);

  final String contact;

  @override
  List<Object> get props => [contact];
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

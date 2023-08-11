part of 'contacts_overview_bloc.dart';

sealed class ContactsOverviewEvent extends Equatable {
  const ContactsOverviewEvent();

  @override
  List<Object> get props => [];
}

final class ContactsOverviewSubscriptionRequested
    extends ContactsOverviewEvent {
  const ContactsOverviewSubscriptionRequested();
}

final class ContactsOverviewContactFavoriteToggled
    extends ContactsOverviewEvent {
  const ContactsOverviewContactFavoriteToggled({
    required this.contact,
    required this.isFavorite,
  });

  final ContactModel contact;
  final bool isFavorite;

  @override
  List<Object> get props => [contact, isFavorite];
}

final class ContactsOverviewContactCreated extends ContactsOverviewEvent {
  const ContactsOverviewContactCreated(this.contact);

  final ContactModel contact;

  @override
  List<Object> get props => [contact];
}

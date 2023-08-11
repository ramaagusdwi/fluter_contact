import 'package:contact_api/contact_api.dart';

/// {@template ContactModels_repository}
/// A repository that handles `ContactModel` related requests.
/// {@endtemplate}
class ContactsRepository {
  /// {@macro ContactModels_repository}
  const ContactsRepository({
    required ContactsApi contactApi,
  }) : _contactsApi = contactApi;

  final ContactsApi _contactsApi;

  /// Provides a [Stream] of all ContactModels.
  Stream<List<ContactModel>> getContacts() => _contactsApi.getContacts();

  /// Saves a [Contact].
  ///
  /// If a [Contact] with the same id already exists, it will be replaced.
  Future<void> saveContactModel(ContactModel contact) =>
      _contactsApi.saveContact(contact);

  /// Deletes the `ContactModel` with the given id.
  ///
  /// If no `ContactModel` with the given id exists, a [ContactModelNotFoundException] error is
  /// thrown.
  Future<void> deleteContactModel(String id) => _contactsApi.deleteContact(id);

  /// Sets the `isFavorite` state of single ContactModels to the given value.
  ///
  Future<void> favoriteContact({required String id}) =>
      _contactsApi.favorite(id: id);
}

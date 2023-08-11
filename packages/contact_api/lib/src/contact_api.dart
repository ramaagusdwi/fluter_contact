
import 'package:contact_api/src/models/contact_model.dart';

/// {@template Contacts_api}
/// The interface for an API that provides access to a list of Contacts.
/// {@endtemplate}
abstract class ContactsApi {
  /// {@macro Contacts_api}
  const ContactsApi();

  /// Provides a [Stream] of all Contacts.
  Stream<List<ContactModel>> getContacts();

  /// Saves a [Contact].
  ///
  /// If a [Contact] with the same id already exists, it will be replaced.
  Future<void> saveContact(ContactModel Contact);

  /// Deletes the `Contact` with the given id.
  ///
  /// If no `Contact` with the given id exists, a [ContactNotFoundException] error is
  /// thrown.
  Future<void> deleteContact(String id);

  // /// Deletes all completed Contacts.
  // ///
  // /// Returns the number of deleted Contacts.
  // Future<int> clearCompleted();

  // /// Sets the `isCompleted` state of all Contacts to the given value.
  // ///
  // /// Returns the number of updated Contacts.
  // Future<int> completeAll({required bool isCompleted});

  Future<void> favorite({required String id});
}

/// Error thrown when a [Contact] with a given id is not found.
class ContactNotFoundException implements Exception {}
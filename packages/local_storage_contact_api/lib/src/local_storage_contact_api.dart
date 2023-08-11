import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import '../local_storage_contact_api.dart';
import 'package:contact_api/contact_api.dart';

/// {@template local_storage_ContactModels_api}
/// A Flutter implementation of the [ContactsApi] that uses local storage.
/// {@endtemplate}
class LocalStorageContactApi extends ContactsApi {
  /// {@macro local_storage_ContactModels_api}
  LocalStorageContactApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _contactStreamController =
      BehaviorSubject<List<ContactModel>>.seeded(const []);

  /// The key used for storing the ContactModels locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kContactsCollectionKey = '__Contact_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final contactsJson = _getValue(kContactsCollectionKey);
    if (contactsJson != null) {
      final contacts = List<Map<dynamic, dynamic>>.from(
        json.decode(contactsJson) as List,
      )
          .map((jsonMap) =>
              ContactModel.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _contactStreamController.add(contacts);
    } else {
      _contactStreamController.add(const []);
    }
  }

  @override
  Future<void> deleteContact(String id) {
    throw UnimplementedError();
  }

  @override
  Future<int> favorite({required bool isFavorite, required String id}) {
    throw UnimplementedError();
  }

  @override
  Stream<List<ContactModel>> getContacts() =>
      _contactStreamController.asBroadcastStream();

  @override
  Future<void> saveContact(ContactModel contact) {
    final contacts = [..._contactStreamController.value];
    final contactIndex = contacts.indexWhere((t) => t.id == contact.id);
    if (contactIndex >= 0) {
      contacts[contactIndex] = contact;
    } else {
      contacts.add(contact);
    }

    _contactStreamController.add(contacts);
    return _setValue(kContactsCollectionKey, json.encode(contacts));
  }
}

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_contact/bootstrap.dart';
import 'package:local_storage_contact_api/local_storage_contact_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  // final contactsApi = LocalStorageContactApi(
  //   plugin: await SharedPreferences.getInstance(),
  // );

  // bootstrap(contactsApi: contactsApi);
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final contactsApi = LocalStorageContactApi(
    plugin: await SharedPreferences.getInstance(),
  );

    bootstrap(contactsApi: contactsApi);
  }, (error, stack) => log(error.toString(), stackTrace: stack));
}

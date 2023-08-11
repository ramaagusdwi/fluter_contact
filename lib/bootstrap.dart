import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:contact_api/contact_api.dart';
import 'package:contacts_repository/contacts_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contact/app_bloc_observer.dart';

import 'app.dart';

void bootstrap({required ContactsApi contactsApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  final contactsRepository = ContactsRepository(contactApi: contactsApi);

  // runZonedGuarded(
  //   () {
  //     runApp(App(contactsRepository: contactsRepository));
  //   },
  //   (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  // );
  runApp(App(contactsRepository: contactsRepository));
}

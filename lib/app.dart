import 'package:authentication_repository/authentication_repository.dart';
import 'package:contacts_repository/contacts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contact/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_contact/home/view/home_page.dart';
import 'package:flutter_contact/login/view/login_page.dart';
import 'package:flutter_contact/splash/view/splash_page.dart';
import 'package:flutter_contact/theme/theme.dart';

import 'contacts_overview/view/contacts_overview_page.dart';

class App extends StatefulWidget {
  const App({required this.contactsRepository, super.key});

  final ContactsRepository contactsRepository;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: widget.contactsRepository),
      ],
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlutterContactsTheme.light,
      darkTheme: FlutterContactsTheme.dark,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        // return SizedBox.shrink();
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  ContactsOverviewPage.route(),
                  (route) => false,
                );
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}

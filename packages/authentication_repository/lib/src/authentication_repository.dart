import 'dart:async';

import 'package:authentication_repository/src/dio_client.dart';
import 'package:authentication_repository/src/models/user.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    final DioClient client = DioClient();
    String? token = await client.login(email: email, password: password);
    if (token != null) {
      await Future.delayed(
        const Duration(milliseconds: 300),
        () => _controller.add(AuthenticationStatus.authenticated),
      );
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}

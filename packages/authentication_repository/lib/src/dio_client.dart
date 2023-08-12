import 'package:authentication_repository/src/models/user.dart';
import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio = Dio();

  final _baseUrl = 'https://reqres.in/api';

  // TODO: Add methods
  Future<User?> getUser({required String id}) async {
    User? user;
    try {
      Response userData = await _dio.get('$_baseUrl/users/$id');
      print('User Info: ${userData.data}');
      user = User.fromJson(userData.data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return user;
  }

  //login method here
  Future<String?> login(
      {required String email, required String password}) async {
    String? token;
    try {
      Response userData = await _dio.post(
        '$_baseUrl/login',
        data: {'email': email, 'password': password},
      );

      print('User Info: ${userData.data}');
      var map = userData.data as Map<String, dynamic>;
      token = map['token'];
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return token;
  }
}

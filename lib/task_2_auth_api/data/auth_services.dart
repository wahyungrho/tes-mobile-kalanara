import 'package:flutter_tes_mobile_kalanara_group/task_2_auth_api/data/shared_preference_service.dart';

class AuthServices {
  Future<String> login(String username, String password) async {
    await Future.delayed(Duration(seconds: 2));
    if (username == 'user' && password == 'password') {
      // simulaste hit api

      // final apiUrl = 'https://api.example.com/login';
      // final response = await http.post(Uri.parse(apiUrl), body: {
      //       'username': username, 'password': password});

      // if (response.statusCode == 200) {
      // final data = jsonDecode(response.body);
      // if (data['success']) {
      //   final token = data['token'];
      //   SharedPreferenceService().saveToken(token);
      //   return token;
      // } else {
      //   throw Exception('Failed to login');
      // }
      // } else {
      //   throw Exception('Failed to login');
      // }

      // generate a random token string
      String token = 'Bearer ${DateTime.now().millisecondsSinceEpoch}';
      // Save token to shared preferences
      await SharedPreferenceService().saveToken(token);
      return token;
    } else {
      throw Exception('Invalid username or password');
    }
  }

  Future<void> logout() async {
    // Remove token from shared preferences
    await SharedPreferenceService().clear();
  }

  // hasToken
  bool hasToken() {
    return SharedPreferenceService().hasToken();
  }

  // getToken
  String? getToken() {
    return SharedPreferenceService().getToken();
  }
}

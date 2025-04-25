import 'package:flutter_tes_mobile_kalanara_group/task_2_auth_api/data/auth_services.dart';

class AuthRepositories {
  // Define the methods and properties for the AuthRepositories class
  // This class will handle authentication-related operations
  // such as login, logout.

  final AuthServices _authServices = AuthServices();

  Future<String> login(String username, String password) async {
    // Implement login logic here
    return _authServices.login(username, password);
  }

  void logout() async {
    // Implement logout logic here
    _authServices.logout();
  }

  bool hasToken() {
    // Check if the token exists in shared preferences
    return _authServices.hasToken();
  }

  String? getToken() {
    // Get the token from shared preferences
    return _authServices.getToken();
  }
}

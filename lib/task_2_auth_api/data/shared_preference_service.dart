import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static final SharedPreferenceService _instance =
      SharedPreferenceService._internal();

  factory SharedPreferenceService() {
    return _instance;
  }

  SharedPreferenceService._internal();

  // SharedPreferences instance
  SharedPreferences? _prefs;

  // Initialize the shared preferences
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Save token to shared preferences
  Future<void> saveToken(String token) async {
    await _prefs?.setString('token', token);
  }

  // Get token from shared preferences
  String? getToken() {
    if (_prefs == null) {
      throw Exception('SharedPreferences not initialized. Call init() first.');
    }
    return _prefs!.getString('token');
  }

  // Remove token from shared preferences
  Future<void> removeToken() async {
    if (_prefs == null) {
      throw Exception('SharedPreferences not initialized. Call init() first.');
    }
    await _prefs!.remove('token');
  }

  bool hasToken() {
    if (_prefs == null) {
      throw Exception('SharedPreferences not initialized. Call init() first.');
    }
    return _prefs!.containsKey('token');
  }

  // clear all data from shared preferences
  Future<void> clear() async {
    if (_prefs == null) {
      throw Exception('SharedPreferences not initialized. Call init() first.');
    }
    await _prefs!.clear();
  }
}

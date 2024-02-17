import 'package:shared_preferences/shared_preferences.dart';

class PersistenceManager {
  static final PersistenceManager _instance = PersistenceManager._internal();

  factory PersistenceManager() {
    return _instance;
  }

  PersistenceManager._internal() {
    SharedPreferences.getInstance().then((value) => preferences = value);
  }

  late SharedPreferences preferences;

  static String getUsername() {
    return _instance.preferences.getString("username") ?? "";
  }

  static String getPassword() {
    return _instance.preferences.getString("password") ?? "";
  }
}

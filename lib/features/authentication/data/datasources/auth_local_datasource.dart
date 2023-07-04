import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthenticationLocalDataSource {
  Future<void> saveSessionId(String sessionId);
  Future<void> deleteSessionId();
  Future<String> getSessionId();
  Future<void> onBoardUser();
  Future<bool> checkOnBoardUser();
}

class AuthenticationLocalImpl implements AuthenticationLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthenticationLocalImpl(this.sharedPreferences);

  @override
  Future<void> saveSessionId(String sessionId) async {
    await sharedPreferences.setString('session_id', sessionId);
  }

  @override
  Future<void> deleteSessionId() async {
    await sharedPreferences.remove('session_id');
  }

  @override
  Future<String> getSessionId() async {
    final value = sharedPreferences.getString('session_id');
    return value.toString();
  }

  @override
  Future<bool> checkOnBoardUser() async {
    final value = sharedPreferences.getBool('onboard_user');
    if (value == null) {
      return false;
    } else if (value == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> onBoardUser() async {
    await sharedPreferences.setBool('onboard_user', true);
  }
}

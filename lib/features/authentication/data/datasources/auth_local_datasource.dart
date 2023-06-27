import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthenticationLocalDataSource {
  Future<void> saveSessionId(String sessionId);
  Future<void> deleteSessionId();
  Future<String> getSessionId();
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
    final value = await sharedPreferences.getString('session_id');
    print(value.toString());
    return value.toString();
  }
}

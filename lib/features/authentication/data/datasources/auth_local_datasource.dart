import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthenticationLocalDataSource {
  Future<void> saveSessionId(String sessionId);
}

class AuthenticationLocalImpl implements AuthenticationLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthenticationLocalImpl(this.sharedPreferences);

  @override
  Future<void> saveSessionId(String sessionId) async {
    sharedPreferences.setString('session_id', sessionId);
  }
}

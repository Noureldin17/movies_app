import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/authentication/domain/models/request_token_model.dart';

abstract class AuthenticationRepo {
  Future<Either<Failure, Unit>> loginUser(Map<String, dynamic> params);
  Future<Either<Failure, Unit>> guestLoginUser();
  Future<Either<Failure, Unit>> logoutUser();
}

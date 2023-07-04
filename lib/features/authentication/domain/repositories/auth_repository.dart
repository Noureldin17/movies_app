import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failures.dart';

abstract class AuthenticationRepo {
  Future<Either<Failure, Unit>> loginUser(Map<String, dynamic> params);
  Future<Either<Failure, Unit>> guestLoginUser();
  Future<Either<Failure, Unit>> logoutUser();
  Future<Either<Failure, Unit>> onBoardUser();
  Future<Either<Failure, bool>> checkOnBoardUser();
}

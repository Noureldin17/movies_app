import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/authentication/domain/models/login_request_params.dart';
import 'package:movies_app/features/authentication/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthenticationRepo authenticationRepo;

  LoginUseCase(this.authenticationRepo);

  Future<Either<Failure, Unit>> call(
      LoginRequestParams loginRequestParams) async {
    return await authenticationRepo.loginUser(loginRequestParams.toJson());
  }
}

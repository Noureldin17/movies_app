import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/authentication/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthenticationRepo authenticationRepo;

  LogoutUseCase(this.authenticationRepo);

  Future<Either<Failure, Unit>> call() async {
    return await authenticationRepo.logoutUser();
  }
}

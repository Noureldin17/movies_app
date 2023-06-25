import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/authentication/domain/repositories/auth_repository.dart';

class GuestLoginUseCase {
  final AuthenticationRepo authenticationRepo;

  GuestLoginUseCase(this.authenticationRepo);

  Future<Either<Failure, Unit>> call() async {
    return await authenticationRepo.guestLoginUser();
  }
}

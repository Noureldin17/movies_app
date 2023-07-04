import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/authentication/domain/repositories/auth_repository.dart';

class OnBoardUseCase {
  final AuthenticationRepo authenticationRepo;

  OnBoardUseCase(this.authenticationRepo);

  Future<Either<Failure, Unit>> call() async {
    return await authenticationRepo.onBoardUser();
  }
}

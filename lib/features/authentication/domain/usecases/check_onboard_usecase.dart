import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/authentication/domain/repositories/auth_repository.dart';

class CheckOnBoardUseCase {
  final AuthenticationRepo authenticationRepo;

  CheckOnBoardUseCase(this.authenticationRepo);

  Future<Either<Failure, bool>> call() async {
    return await authenticationRepo.checkOnBoardUser();
  }
}

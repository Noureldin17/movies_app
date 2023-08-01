import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/authentication/domain/repositories/auth_repository.dart';

class DeleteRatingUsecase {
  final AuthenticationRepo authenticationRepo;

  DeleteRatingUsecase(this.authenticationRepo);

  Future<Either<Failure, Unit>> call(int movieId) async {
    return await authenticationRepo.deleteRating(movieId);
  }
}

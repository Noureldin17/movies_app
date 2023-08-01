import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/authentication/domain/models/tmdb_user_model.dart';
import 'package:movies_app/features/authentication/domain/repositories/auth_repository.dart';

class GetUserDetailsUsecase {
  final AuthenticationRepo authenticationRepo;

  GetUserDetailsUsecase(this.authenticationRepo);

  Future<Either<Failure, TMDBUser>> call() async {
    return await authenticationRepo.getUserDetails();
  }
}

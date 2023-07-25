import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:movies_app/features/movies/domain/models/movie_model.dart';

class GetWatchListUsecase {
  final AuthenticationRepo authenticationRepo;

  GetWatchListUsecase(this.authenticationRepo);

  Future<Either<Failure, List<Movie>>> call() async {
    return await authenticationRepo.getWatchList();
  }
}

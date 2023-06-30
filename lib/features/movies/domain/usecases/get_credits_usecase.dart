import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/movies/domain/models/movie_credits_model.dart';
import 'package:movies_app/features/movies/domain/repositories/movies_repository.dart';

class GetCreditsUseCase {
  final MoviesRepository moviesRepository;

  GetCreditsUseCase(this.moviesRepository);

  Future<Either<Failure, List<Member>>> call(int movieId) async {
    return await moviesRepository.getMovieCredits(movieId);
  }
}

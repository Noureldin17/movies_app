import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/movies/domain/models/movie_model.dart';
import 'package:movies_app/features/movies/domain/repositories/movies_repository.dart';

class GetUpcomingMoviesUseCase {
  final MoviesRepository moviesRepository;

  GetUpcomingMoviesUseCase(this.moviesRepository);

  Future<Either<Failure, List<Movie>>> call(int page) async {
    return await moviesRepository.getUpcomingMovies(page);
  }
}

import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/movies/domain/models/movie_model.dart';
import 'package:movies_app/features/movies/domain/repositories/movies_repository.dart';

class GetTopRatedMoviesUseCase {
  final MoviesRepository moviesRepository;

  GetTopRatedMoviesUseCase(this.moviesRepository);

  Future<Either<Failure, List<Movie>>> call(int page) async {
    return await moviesRepository.getTopRatedMovies(page);
  }
}

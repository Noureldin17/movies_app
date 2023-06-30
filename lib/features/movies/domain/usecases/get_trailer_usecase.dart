import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/movies/domain/models/movie_videos_model.dart';
import 'package:movies_app/features/movies/domain/repositories/movies_repository.dart';

class GetTrailerUseCase {
  final MoviesRepository moviesRepository;

  GetTrailerUseCase(this.moviesRepository);

  Future<Either<Failure, List<MovieVideo>>> call(int movieId) async {
    return await moviesRepository.getMovieTrailer(movieId);
  }
}

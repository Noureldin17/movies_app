import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/movies/domain/models/movies_details_model.dart';

import '../models/movie_credits_model.dart';
import '../models/movie_model.dart';
import '../models/movie_videos_model.dart';

abstract class MoviesRepository {
  Future<Either<Failure, List<Movie>>> getMovies(int page);

  Future<Either<Failure, List<MovieVideo>>> getMovieTrailer(int movieId);

  Future<Either<Failure, List<Member>>> getMovieCredits(int movieId);

  Future<Either<Failure, MovieDetails>> getMovieDetails(int movieId);

  Future<Either<Failure, List<Movie>>> getTopRatedMovies(int page);

  Future<Either<Failure, List<Movie>>> getUpcomingMovies(int page);

  Future<Either<Failure, List<Movie>>> getArabicMovies(int page);
}

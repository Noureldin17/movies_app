import 'package:movies_app/features/movies/domain/models/movie_model.dart';

class MovieDetailArgs {
  final String tag;
  final Movie movie;
  // final CacheManager cacheManager;
  MovieDetailArgs(
    this.tag,
    this.movie,
  );
}

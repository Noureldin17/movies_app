import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/movies/domain/models/movie_model.dart';
import 'package:movies_app/features/search/domain/repositories/search_repository.dart';

class SearchMoviesUsecase {
  final SearchRepository searchRepository;

  SearchMoviesUsecase(this.searchRepository);

  Future<Either<Failure, List<Movie>>> call(String query, int page) async {
    return await searchRepository.searchMovies(query, page);
  }
}

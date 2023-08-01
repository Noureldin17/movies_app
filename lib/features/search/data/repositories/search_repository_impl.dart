import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/core/network/network_info.dart';
import 'package:movies_app/features/movies/domain/models/movie_model.dart';
import 'package:movies_app/features/search/data/datasources/search_remote_datasource.dart';
import 'package:movies_app/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDatasource searchRemoteDatasource;
  final NetworkInfo networkInfo;

  SearchRepositoryImpl(this.searchRemoteDatasource, this.networkInfo);
  @override
  Future<Either<Failure, List<Movie>>> searchMovies(
      String query, int page) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await searchRemoteDatasource.searchMovies(query, page);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      } on EmptyResultException {
        return Left(EmptyResultFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}

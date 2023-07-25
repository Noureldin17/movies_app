// ignore_for_file: unnecessary_null_comparison
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/network/network_info.dart';
import 'package:movies_app/features/authentication/data/datasources/auth_local_datasource.dart';
import 'package:movies_app/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:movies_app/features/authentication/domain/models/request_token_model.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:movies_app/features/movies/domain/models/movie_model.dart';

class AuthenticationRepoImpl implements AuthenticationRepo {
  final AuthenticationRemoteDataSource remoteDataSource;
  final AuthenticationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthenticationRepoImpl(
      this.remoteDataSource, this.localDataSource, this.networkInfo);

  Future<Either<Failure, RequestTokenModel>> _getRequestToken() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getRequestToken();
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      } on InvalidCredentialsException {
        return Left(InvalidCredentialsFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> loginUser(Map<String, dynamic> params) async {
    final response = await _getRequestToken();
    final token1 = response.fold((l) => null, (r) => r.requestToken);
    if (await networkInfo.isConnected) {
      try {
        params.putIfAbsent('request_token', () => token1);
        final validateWithLoginToken =
            await remoteDataSource.validateWithLogin(params);
        final sessionId = await remoteDataSource
            .createSession(validateWithLoginToken.toJson());
        if (sessionId != null) {
          localDataSource.saveSessionId(sessionId);
          return const Right(unit);
        } else {
          return Left(InvalidCredentialsFailure());
        }
      } on ServerException {
        return Left(ServerFailure());
      } on InvalidCredentialsException {
        return Left(InvalidCredentialsFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logoutUser() async {
    if (await networkInfo.isConnected) {
      try {
        final id = await localDataSource.getSessionId();
        localDataSource.deleteSessionId();
        // ignore: unused_local_variable
        final response = await remoteDataSource.deleteSession(id);
        return const Right(unit);
      } on InvalidCredentialsException {
        return Left(InvalidCredentialsFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> guestLoginUser() async {
    if (await networkInfo.isConnected) {
      try {
        final sessionId = await remoteDataSource.createGuestSession();
        if (sessionId != null) {
          localDataSource.saveSessionId(sessionId);
          return const Right(unit);
        } else {
          return Left(InvalidCredentialsFailure());
        }
      } on ServerException {
        return Left(ServerFailure());
      } on InvalidCredentialsException {
        return Left(InvalidCredentialsFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> checkOnBoardUser() async {
    final value = await localDataSource.checkOnBoardUser();
    return Right(value);
  }

  @override
  Future<Either<Failure, Unit>> onBoardUser() async {
    try {
      await localDataSource.onBoardUser();
      return const Right(unit);
    } catch (_) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addToWatchList(int movieId, bool value) async {
    if (await networkInfo.isConnected) {
      try {
        final sessionId = await localDataSource.getSessionId();
        await remoteDataSource.addToWatchList(movieId, value, sessionId);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on UnAuthorizedException {
        return Left(UnAuthorizedFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getWatchList() async {
    if (await networkInfo.isConnected) {
      try {
        final sessionId = await localDataSource.getSessionId();
        final response = await remoteDataSource.getWatchList(sessionId);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      } on UnAuthorizedException {
        return Left(UnAuthorizedFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}

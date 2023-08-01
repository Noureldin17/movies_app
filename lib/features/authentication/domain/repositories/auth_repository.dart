import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/movies/domain/models/login_states_model.dart';
import 'package:movies_app/features/movies/domain/models/movie_model.dart';

import '../models/tmdb_user_model.dart';

abstract class AuthenticationRepo {
  Future<Either<Failure, Unit>> loginUser(
      Map<String, dynamic> params, bool keepMeSignedIn);
  Future<Either<Failure, Unit>> guestLoginUser();
  Future<Either<Failure, Unit>> logoutUser();
  Future<Either<Failure, Unit>> onBoardUser();
  Future<Either<Failure, LoginStates>> checkLoginStatesUser();
  Future<Either<Failure, List<Movie>>> getWatchList();
  Future<Either<Failure, Unit>> addToWatchList(int movieId, bool value);
  Future<Either<Failure, Unit>> addRating(int movieId, num value);
  Future<Either<Failure, Unit>> deleteRating(int movieId);
  Future<Either<Failure, TMDBUser>> getUserDetails();
}

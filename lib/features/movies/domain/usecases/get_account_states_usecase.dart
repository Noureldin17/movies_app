import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/movies/domain/models/account_states_model.dart';
import 'package:movies_app/features/movies/domain/repositories/movies_repository.dart';

class GetAccountStatesUsecase {
  final MoviesRepository moviesRepository;

  GetAccountStatesUsecase(this.moviesRepository);

  Future<Either<Failure, AccountStates>> call(int movieId) async {
    return await moviesRepository.getAccountStates(movieId);
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/features/movies/domain/usecases/get_credits_usecase.dart';
import 'package:movies_app/features/movies/domain/usecases/get_movies_usecase.dart';
import 'package:movies_app/features/movies/domain/usecases/get_top_rated_usecase.dart';
import 'package:movies_app/features/movies/domain/usecases/get_trailer_usecase.dart';
import 'package:movies_app/features/movies/domain/usecases/get_upcoming_usecase.dart';

import '../../domain/models/movie_model.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetCreditsUseCase getCreditsUseCase;
  final GetMoviesUseCase getMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;
  final GetTrailerUseCase getTrailerUseCase;
  final GetUpcomingMoviesUseCase getUpcomingMoviesUseCase;

  MoviesBloc({
    required this.getCreditsUseCase,
    required this.getMoviesUseCase,
    required this.getTopRatedMoviesUseCase,
    required this.getTrailerUseCase,
    required this.getUpcomingMoviesUseCase,
  }) : super(MoviesInitial()) {
    on<MoviesEvent>((event, emit) async {
      if (event is GetMoviesEvent) {
        final response = await getMoviesUseCase.call(1);

        response.fold(
            (l) => emit(MoviesError()), (r) => emit(MoviesSuccess(r)));
      }
    });
  }
}

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/features/movies/domain/usecases/get_credits_usecase.dart';
import 'package:movies_app/features/movies/domain/usecases/get_movies_usecase.dart';
import 'package:movies_app/features/movies/domain/usecases/get_trailer_usecase.dart';

import '../../../../core/error/failures.dart';
import '../../domain/models/movie_model.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetCreditsUseCase getCreditsUseCase;
  final GetMoviesUseCase getMoviesUseCase;
  final GetTrailerUseCase getTrailerUseCase;

  int _page = 1;
  int _pageToprated = 1;
  int _pageUpcoming = 1;

  MoviesBloc({
    required this.getCreditsUseCase,
    required this.getMoviesUseCase,
    required this.getTrailerUseCase,
  }) : super(MoviesInitial()) {
    on<MoviesEvent>(transformer: sequential(), (event, emit) async {
      if (event is GetMoviesEvent) {
        await _getMoviesHandler(event, emit);
      } else if (event is GetTopRatedMoviesEvent) {
        await _getTopRatedMoviesHandler(event, emit);
      } else if (event is GetUpcomingMoviesEvent) {
        await _getUpcomingMoviesHandler(event, emit);
      }
    });
  }

  Future<void> _getMoviesHandler(event, emit) async {
    emit(MoviesLoading());
    final response = await getMoviesUseCase.call(_page, event.type);

    response.fold((l) => emit(MoviesError(_mapErrorToMessage(l))), (r) {
      _page += 1;
      emit(MoviesSuccess(r));
    });
  }

  Future<void> _getTopRatedMoviesHandler(event, emit) async {
    emit(TopRatedLoading());
    final response = await getMoviesUseCase.call(_pageToprated, event.type);
    response.fold((l) => emit(TopRatedError(_mapErrorToMessage(l))), (r) {
      _pageToprated += 1;
      emit(TopRatedSuccess(r));
    });
  }

  Future<void> _getUpcomingMoviesHandler(event, emit) async {
    emit(UpcomingLoading());
    final response = await getMoviesUseCase.call(_pageUpcoming, event.type);
    response.fold((l) => emit(UpcomingError(_mapErrorToMessage(l))), (r) {
      _pageUpcoming += 1;
      emit(UpcomingSuccess(r));
    });
  }

  String _mapErrorToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "An error has occured with the server";
      case NetworkFailure:
        return "Connection Error";
      default:
        return "An error has occured ";
    }
  }
}

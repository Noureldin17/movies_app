// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/features/movies/domain/usecases/get_credits_usecase.dart';
import 'package:movies_app/features/movies/domain/usecases/get_details_usecase.dart';
import 'package:movies_app/features/movies/domain/usecases/get_movies_usecase.dart';
import 'package:movies_app/features/movies/domain/usecases/get_trailer_usecase.dart';

import '../../../../core/error/failures.dart';
import '../../domain/models/movie_credits_model.dart';
import '../../domain/models/movie_model.dart';
import '../../domain/models/movie_videos_model.dart';
import '../../domain/models/movies_details_model.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetCreditsUseCase getCreditsUseCase;
  final GetMoviesUseCase getMoviesUseCase;
  final GetTrailerUseCase getTrailerUseCase;
  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  int page = 1;
  int pageToprated = 1;
  int pageUpcoming = 1;
  int pageArabic = 1;

  MoviesBloc(
      {required this.getCreditsUseCase,
      required this.getMoviesUseCase,
      required this.getTrailerUseCase,
      required this.getMovieDetailsUseCase})
      : super(MoviesInitial()) {
    on<MoviesEvent>(transformer: sequential(), (event, emit) async {
      if (event is GetMoviesEvent) {
        await _getMoviesHandler(event, emit);
      } else if (event is GetTopRatedMoviesEvent) {
        await _getTopRatedMoviesHandler(event, emit);
      } else if (event is GetUpcomingMoviesEvent) {
        await _getUpcomingMoviesHandler(event, emit);
      } else if (event is GetArabicMoviesEvent) {
        await _getArabicMoviesHandler(event, emit);
      } else if (event is GetDetailsEvent) {
        await _getDetailsHandler(event, emit);
      } else if (event is GetCreditsEvent) {
        await _getCreditsHandler(event, emit);
      } else if (event is GetTrailerEvent) {
        await _getTrailerHandler(event, emit);
      }
    });
  }

  Future<void> _getTrailerHandler(event, emit) async {
    emit(TrailerLoading());
    final response = await getTrailerUseCase.call(event.movieId);
    response.fold((l) => emit(TrailerError(_mapErrorToMessage(l))),
        (r) => emit(TrailerSuccess(r)));
  }

  Future<void> _getDetailsHandler(event, emit) async {
    emit(DetailsLoading());
    final response = await getMovieDetailsUseCase.call(event.movieId);
    response.fold((l) => emit(DetailsError(_mapErrorToMessage(l))),
        (r) => emit(DetailsSuccess(r)));
  }

  Future<void> _getCreditsHandler(event, emit) async {
    emit(CreditsLoading());
    final response = await getCreditsUseCase.call(event.movieId);
    response.fold((l) => emit(CreditsError(_mapErrorToMessage(l))),
        (r) => emit(CreditsSuccess(r)));
  }

  Future<void> _getMoviesHandler(event, emit) async {
    emit(MoviesLoading());
    final response = await getMoviesUseCase.call(page, event.type);

    response.fold((l) => emit(MoviesError(_mapErrorToMessage(l))), (r) {
      page += 1;
      emit(MoviesSuccess(r));
    });
  }

  Future<void> _getTopRatedMoviesHandler(event, emit) async {
    emit(TopRatedLoading());
    final response = await getMoviesUseCase.call(pageToprated, event.type);
    response.fold((l) => emit(TopRatedError(_mapErrorToMessage(l))), (r) {
      pageToprated += 1;
      emit(TopRatedSuccess(
        r,
      ));
    });
  }

  Future<void> _getArabicMoviesHandler(event, emit) async {
    emit(ArabicLoading());
    final response = await getMoviesUseCase.call(pageArabic, event.type);
    response.fold((l) => emit(ArabicError(_mapErrorToMessage(l))), (r) {
      pageArabic += 1;
      emit(ArabicSuccess(r));
    });
  }

  Future<void> _getUpcomingMoviesHandler(event, emit) async {
    emit(UpcomingLoading());
    final response = await getMoviesUseCase.call(pageUpcoming, event.type);
    response.fold((l) => emit(UpcomingError(_mapErrorToMessage(l))), (r) {
      pageUpcoming += 1;
      emit(UpcomingSuccess(r));
    });
  }

  String _mapErrorToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "An error has occured with the server";
      case NetworkFailure:
        return "Connection Error";
      case EmptyResultFailure:
        return "There is no trailer available for this movie";
      default:
        return "An error has occured ";
    }
  }
}

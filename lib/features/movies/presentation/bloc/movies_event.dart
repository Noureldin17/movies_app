part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class GetMoviesEvent extends MoviesEvent {
  final String type;

  const GetMoviesEvent(this.type);
}

class GetTopRatedMoviesEvent extends MoviesEvent {
  final String type;

  const GetTopRatedMoviesEvent(this.type);
}

class GetUpcomingMoviesEvent extends MoviesEvent {
  final String type;

  const GetUpcomingMoviesEvent(this.type);
}

class GetArabicMoviesEvent extends MoviesEvent {
  final String type;

  const GetArabicMoviesEvent(this.type);
}

class GetTrailerEvent extends MoviesEvent {
  final int movieId;

  const GetTrailerEvent(this.movieId);
}

class GetCreditsEvent extends MoviesEvent {
  final int movieId;

  const GetCreditsEvent(this.movieId);
}

class GetDetailsEvent extends MoviesEvent {
  final int movieId;

  const GetDetailsEvent(this.movieId);
}

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

class GetTrailerMoviesEvent extends MoviesEvent {}

class GetCreditsMoviesEvent extends MoviesEvent {}

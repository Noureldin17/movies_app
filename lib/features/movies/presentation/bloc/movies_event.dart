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

// class GetTopRatedMoviesEvent extends MoviesEvent {}

// class GetUpcomingMoviesEvent extends MoviesEvent {}

class GetTrailerMoviesEvent extends MoviesEvent {}

class GetCreditsMoviesEvent extends MoviesEvent {}

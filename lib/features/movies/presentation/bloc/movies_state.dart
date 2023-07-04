part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class TopRatedLoading extends MoviesState {}

class UpcomingLoading extends MoviesState {}

class MoviesSuccess extends MoviesState {
  final List<Movie> movieList;

  const MoviesSuccess(this.movieList);
}

class TopRatedSuccess extends MoviesState {
  final List<Movie> movieList;

  const TopRatedSuccess(this.movieList);
}

class UpcomingSuccess extends MoviesState {
  final List<Movie> movieList;

  const UpcomingSuccess(this.movieList);
}

class MoviesError extends MoviesState {
  final String message;

  const MoviesError(this.message);
}

class TopRatedError extends MoviesState {
  final String message;

  const TopRatedError(this.message);
}

class UpcomingError extends MoviesState {
  final String message;

  const UpcomingError(this.message);
}

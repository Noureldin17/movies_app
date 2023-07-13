part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class TrailerLoading extends MoviesState {}

class DetailsLoading extends MoviesState {}

class CreditsLoading extends MoviesState {}

class TrailerError extends MoviesState {
  final String message;

  const TrailerError(this.message);
}

class CreditsError extends MoviesState {
  final String message;

  const CreditsError(this.message);
}

class DetailsError extends MoviesState {
  final String message;

  const DetailsError(this.message);
}

class TopRatedLoading extends MoviesState {}

class UpcomingLoading extends MoviesState {}

class ArabicLoading extends MoviesState {}

class TrailerSuccess extends MoviesState {
  final List<MovieVideo> trailer;

  const TrailerSuccess(this.trailer);
}

class CreditsSuccess extends MoviesState {
  final List<Member> castsList;

  const CreditsSuccess(this.castsList);
}

class DetailsSuccess extends MoviesState {
  final MovieDetails movieDetails;

  const DetailsSuccess(this.movieDetails);
}

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

class ArabicSuccess extends MoviesState {
  final List<Movie> movieList;

  const ArabicSuccess(this.movieList);
}

class MoviesError extends MoviesState {
  final String message;

  const MoviesError(this.message);
}

class ArabicError extends MoviesState {
  final String message;

  const ArabicError(this.message);
}

class TopRatedError extends MoviesState {
  final String message;

  const TopRatedError(this.message);
}

class UpcomingError extends MoviesState {
  final String message;

  const UpcomingError(this.message);
}

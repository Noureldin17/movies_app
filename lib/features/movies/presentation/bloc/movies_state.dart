part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesSuccess extends MoviesState {
  final List<Movie> movieList;

  const MoviesSuccess(this.movieList);
}

class MoviesError extends MoviesState {}

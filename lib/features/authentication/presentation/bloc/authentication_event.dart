part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthenticationEvent {
  final String username, password;

  const LoginEvent(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class GuestLoginEvent extends AuthenticationEvent {}

class LogoutEvent extends AuthenticationEvent {}

class OnBoardEvent extends AuthenticationEvent {}

class CheckOnBoardEvent extends AuthenticationEvent {}

class AddToWatchListEvent extends AuthenticationEvent {
  final int movieId;
  final bool value;

  const AddToWatchListEvent(this.movieId, this.value);
}

class GetWatchListEvent extends AuthenticationEvent {}

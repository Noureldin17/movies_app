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

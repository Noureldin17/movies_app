part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class LoginSuccessState extends AuthenticationState {}

class LoginLoadingState extends AuthenticationState {}

class LogoutLoadingState extends AuthenticationState {}

class GuestLoginSuccessState extends AuthenticationState {}

class GuestLogoutSuccessState extends AuthenticationState {}

class LogoutSuccessState extends AuthenticationState {}

class LoginErrorState extends AuthenticationState {
  final String message;

  const LoginErrorState(this.message);
}

class LogoutErrorState extends AuthenticationState {
  final String message;

  const LogoutErrorState(this.message);
}

class GuestLoginErrorState extends AuthenticationState {
  final String message;

  const GuestLoginErrorState(this.message);
}

class OnBoardCheckedState extends AuthenticationState {
  final bool isOnBoard;

  const OnBoardCheckedState(this.isOnBoard);
}
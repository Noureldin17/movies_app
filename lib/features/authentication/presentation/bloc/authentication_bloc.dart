// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:http/http.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/authentication/domain/models/login_request_params.dart';
import 'package:movies_app/features/authentication/domain/usecases/check_onboard_usecase.dart';
import 'package:movies_app/features/authentication/domain/usecases/guest_login_usecase.dart';
import 'package:movies_app/features/authentication/domain/usecases/login_usecase.dart';
import 'package:movies_app/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:movies_app/features/authentication/domain/usecases/onboard_usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUseCase loginUseCase;
  final GuestLoginUseCase guestLoginUseCase;
  final LogoutUseCase logoutUseCase;
  final OnBoardUseCase onBoardUseCase;
  final CheckOnBoardUseCase checkOnBoardUseCase;
  AuthenticationBloc(
      {required this.loginUseCase,
      required this.guestLoginUseCase,
      required this.checkOnBoardUseCase,
      required this.onBoardUseCase,
      required this.logoutUseCase})
      : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoadingState());
        final response = await loginUseCase
            .call(LoginRequestParams(event.username, event.password));

        response.fold((l) {
          emit(LoginErrorState(_mapErrorToMessage(l)));
        }, (r) {
          emit(LoginSuccessState());
        });
      } else if (event is GuestLoginEvent) {
        emit(LoginLoadingState());
        final response = await guestLoginUseCase.call();

        response.fold((l) => emit(GuestLoginErrorState(_mapErrorToMessage(l))),
            (r) => emit(GuestLoginSuccessState()));
      } else if (event is LogoutEvent) {
        emit(LogoutLoadingState());
        final response = await logoutUseCase.call();
        response.fold((l) => emit(LogoutErrorState(_mapErrorToMessage(l))),
            (r) => emit(LogoutSuccessState()));
      } else if (event is OnBoardEvent) {
        // ignore: unused_local_variable
        final response = await onBoardUseCase.call();
      } else if (event is CheckOnBoardEvent) {
        final response = await checkOnBoardUseCase.call();
        response.fold((l) => null, (r) {
          emit(OnBoardCheckedState(r));
        });
      }
    });
  }

  String _mapErrorToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "An error has occured with the server";
      case InvalidCredentialsFailure:
        return "Invalid username or password";
      case NetworkFailure:
        return "Connection Error";
      default:
        return "An error has occured ";
    }
  }
}

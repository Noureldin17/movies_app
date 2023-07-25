// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/authentication/domain/models/login_request_params.dart';
import 'package:movies_app/features/authentication/domain/usecases/add_to_watchlist_usecase.dart';
import 'package:movies_app/features/authentication/domain/usecases/check_onboard_usecase.dart';
import 'package:movies_app/features/authentication/domain/usecases/get_watchlist_usecase.dart';
import 'package:movies_app/features/authentication/domain/usecases/guest_login_usecase.dart';
import 'package:movies_app/features/authentication/domain/usecases/login_usecase.dart';
import 'package:movies_app/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:movies_app/features/authentication/domain/usecases/onboard_usecase.dart';

import '../../../movies/domain/models/movie_model.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUseCase loginUseCase;
  final GuestLoginUseCase guestLoginUseCase;
  final LogoutUseCase logoutUseCase;
  final OnBoardUseCase onBoardUseCase;
  final CheckOnBoardUseCase checkOnBoardUseCase;
  final GetWatchListUsecase getWatchListUsecase;
  final AddToWatchListUsecase addToWatchListUsecase;
  AuthenticationBloc(
      {required this.loginUseCase,
      required this.guestLoginUseCase,
      required this.checkOnBoardUseCase,
      required this.onBoardUseCase,
      required this.addToWatchListUsecase,
      required this.getWatchListUsecase,
      required this.logoutUseCase})
      : super(AuthenticationInitial()) {
    on<AuthenticationEvent>(transformer: sequential(), (event, emit) async {
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
            (r) {
          emit(GuestLoginSuccessState());
        });
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
      } else if (event is GetWatchListEvent) {
        emit(WatchListLoading());
        final response = await getWatchListUsecase.call();

        response.fold((l) => emit(WatchListError(_mapErrorToMessage(l))),
            (r) => emit(WatchListSuccess(r)));
      } else if (event is AddToWatchListEvent) {
        emit(AddToWatchListLoading());

        final response =
            await addToWatchListUsecase.call(event.movieId, event.value);

        response.fold((l) => emit(AddToWatchListError(_mapErrorToMessage(l))),
            (r) {
          emit(AddToWatchListSuccess(event.value));
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
      case UnAuthorizedFailure:
        return "Guests are not authorized to access this feature";
      case NetworkFailure:
        return "Connection Error";
      default:
        return "An error has occured ";
    }
  }
}

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movies_app/core/network/network_info.dart';
import 'package:movies_app/features/authentication/data/datasources/auth_local_datasource.dart';
import 'package:movies_app/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:movies_app/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:movies_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:movies_app/features/authentication/domain/usecases/check_onboard_usecase.dart';
import 'package:movies_app/features/authentication/domain/usecases/guest_login_usecase.dart';
import 'package:movies_app/features/authentication/domain/usecases/login_usecase.dart';
import 'package:movies_app/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:movies_app/features/authentication/domain/usecases/onboard_usecase.dart';
import 'package:movies_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:movies_app/features/movies/data/datasources/movies_local_datasource.dart';
import 'package:movies_app/features/movies/data/datasources/movies_remote_datasource.dart';
import 'package:movies_app/features/movies/data/repositories/movies_repository_impl.dart';
import 'package:movies_app/features/movies/domain/repositories/movies_repository.dart';
import 'package:movies_app/features/movies/domain/usecases/get_credits_usecase.dart';
import 'package:movies_app/features/movies/domain/usecases/get_details_usecase.dart';
import 'package:movies_app/features/movies/domain/usecases/get_movies_usecase.dart';
import 'package:movies_app/features/movies/domain/usecases/get_trailer_usecase.dart';
import 'package:movies_app/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

// feature - Authentication - Movie_Browsing
Future<void> init() async {
  // bloc
  sl.registerFactory(() => AuthenticationBloc(
      loginUseCase: sl(),
      guestLoginUseCase: sl(),
      logoutUseCase: sl(),
      checkOnBoardUseCase: sl(),
      onBoardUseCase: sl()));
  sl.registerFactory(() => MoviesBloc(
      getCreditsUseCase: sl(),
      getMoviesUseCase: sl(),
      getTrailerUseCase: sl(),
      getMovieDetailsUseCase: sl()));
  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => GuestLoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => CheckOnBoardUseCase(sl()));
  sl.registerLazySingleton(() => OnBoardUseCase(sl()));

  sl.registerLazySingleton(() => GetCreditsUseCase(sl()));
  sl.registerLazySingleton(() => GetTrailerUseCase(sl()));
  sl.registerLazySingleton(() => GetMoviesUseCase(sl()));
  sl.registerLazySingleton(() => GetMovieDetailsUseCase(sl()));
  // sl.registerLazySingleton(() => GetTopRatedMoviesUseCase(sl()));
  // sl.registerLazySingleton(() => GetUpcomingMoviesUseCase(sl()));
  // repositories
  sl.registerLazySingleton<AuthenticationRepo>(
      () => AuthenticationRepoImpl(sl(), sl(), sl()));

  sl.registerLazySingleton<MoviesRepository>(
      () => MoviesRepoImpl(sl(), sl(), sl()));
  //datasource
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteImplWithHttp(sl()));
  sl.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalImpl(sl()));
  sl.registerLazySingleton<MoviesRemoteDatasource>(
      () => MoviesRemoteImplWithHttp(sl()));
  sl.registerLazySingleton<MoviesLocalDatasource>(() => MoviesLocalImpl(sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton(() => InternetConnectionChecker());
}

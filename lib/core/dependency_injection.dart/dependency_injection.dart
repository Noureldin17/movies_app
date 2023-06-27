import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movies_app/core/network/network_info.dart';
import 'package:movies_app/features/authentication/data/datasources/auth_local_datasource.dart';
import 'package:movies_app/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:movies_app/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:movies_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:movies_app/features/authentication/domain/usecases/guest_login_usecase.dart';
import 'package:movies_app/features/authentication/domain/usecases/login_usecase.dart';
import 'package:movies_app/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:movies_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

// feature - Authentication
Future<void> init() async {
  // bloc
  sl.registerFactory(() => AuthenticationBloc(
      loginUseCase: sl(), guestLoginUseCase: sl(), logoutUseCase: sl()));
  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => GuestLoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  // repositories
  sl.registerLazySingleton<AuthenticationRepo>(
      () => AuthenticationRepoImpl(sl(), sl(), sl()));
  //datasource
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteImplWithHttp(sl()));
  sl.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalImpl(sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton(() => InternetConnectionChecker());
}

part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _onBoardingInit();
  await _authInit();
}

Future<void> _onBoardingInit() async {
  final prefs = await SharedPreferences.getInstance();
  // logic staff
  sl.registerFactory(() =>
      OnBoardingCubit(cacheFirstTimer: sl(), checkIfUserFirstTimer: sl()));

  // usecase staff
  sl.registerLazySingleton(() => CacheFirstTimerUsecase(repository: sl()));
  sl.registerLazySingleton(
      () => CheckIfUserFirstTimerUsecase(repository: sl()));

  // repository staff
  sl.registerLazySingleton<OnBoardingRepository>(
      () => OnBoardingRepositoryImpl(localDataSource: sl()));

  // datasource staff
  sl.registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSourceImpl(prefs: sl()));

  // External staff
  sl.registerLazySingleton(() => prefs);
}

Future<void> _authInit() async {

  // Business logic
  sl.registerFactory(() => AuthBloc(
      forgotPasswordUsecase: sl(),
      signInUsecase: sl(),
      signUpUsecase: sl(),
      updateUserUsecase: sl()));

  // Usecases
  sl.registerLazySingleton(() => ForgotPasswordUsecase(repository: sl()));
  sl.registerLazySingleton(() => SignInUsecase(repository: sl()));
  sl.registerLazySingleton(() => SignUpUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdateUserUsecase(repository: sl()));

  // repositories
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl()));

  // remote data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
      authClient: sl(), cloudStoreclient: sl(), dbClient: sl()));

  // External dependencies
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);

}

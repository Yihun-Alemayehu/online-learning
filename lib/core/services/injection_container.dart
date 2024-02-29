import 'package:get_it/get_it.dart';
import 'package:online_learning/features/on_boarding/data/datasources/onboarding_local_data_source.dart';
import 'package:online_learning/features/on_boarding/data/repositories/onboarding_repository_impl.dart';
import 'package:online_learning/features/on_boarding/domain/repositories/onboarding_repository.dart';
import 'package:online_learning/features/on_boarding/domain/usecases/cache_first_timer_usecase.dart';
import 'package:online_learning/features/on_boarding/domain/usecases/check_if_user_first_timer_usecase.dart';
import 'package:online_learning/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init () async{
  final prefs = await SharedPreferences.getInstance();
  /// feature ==>> OnBoarding 
    // logic staff
    sl.registerFactory(() => OnBoardingCubit(cacheFirstTimer: sl(), checkIfUserFirstTimer: sl()));

    // usecase staff
    sl.registerLazySingleton(() => CacheFirstTimerUsecase(repository: sl()));
    sl.registerLazySingleton(() => CheckIfUserFirstTimerUsecase(repository: sl()));

    // repository staff
    sl.registerLazySingleton<OnBoardingRepository>(() => OnBoardingRepositoryImpl(localDataSource: sl()));

    // datasource staff
    sl.registerLazySingleton<OnBoardingLocalDataSource>(() => OnBoardingLocalDataSourceImpl(prefs: sl()));

    // External staff
    sl.registerLazySingleton(() => prefs);
}
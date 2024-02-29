import 'package:online_learning/core/usecase/usecase.dart';
import 'package:online_learning/core/utils/typedef.dart';
import 'package:online_learning/features/on_boarding/domain/repositories/onboarding_repository.dart';

class CacheFirstTimerUsecase extends UsecaseWithoutParams<void> {
  final OnBoardingRepository _repository;

  CacheFirstTimerUsecase({required OnBoardingRepository repository}) : _repository = repository;

  @override
  ResultFuture<void> call() async => await _repository.cacheFirstTimer();
 
}

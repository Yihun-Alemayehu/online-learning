import 'package:online_learning/core/usecase/usecase.dart';
import 'package:online_learning/core/utils/typedef.dart';
import 'package:online_learning/features/on_boarding/domain/repositories/onboarding_repository.dart';

class CheckIfUserFirstTimerUsecase extends UsecaseWithoutParams<bool> {
  final OnBoardingRepository _repository;

  CheckIfUserFirstTimerUsecase({required OnBoardingRepository repository}) : _repository = repository;

  @override
  ResultFuture<bool> call() async => await _repository.checkIfUserFirstTimer();
 
}
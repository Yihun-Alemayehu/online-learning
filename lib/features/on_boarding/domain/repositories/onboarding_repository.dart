
import 'package:online_learning/core/utils/typedef.dart';

abstract class OnBoardingRepository {
  ResultFuture<void> cacheFirstTimer();

  ResultFuture<bool> checkIfUserFirstTimer();
}
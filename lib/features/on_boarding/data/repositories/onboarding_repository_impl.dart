import 'package:dartz/dartz.dart';
import 'package:online_learning/core/errors/exception.dart';
import 'package:online_learning/core/errors/failure.dart';
import 'package:online_learning/core/utils/typedef.dart';
import 'package:online_learning/features/on_boarding/data/datasources/onboarding_local_data_source.dart';
import 'package:online_learning/features/on_boarding/domain/repositories/onboarding_repository.dart';

class OnBoardingRepositoryImpl implements OnBoardingRepository {
  final OnBoardingLocalDataSource _localDataSource;

  OnBoardingRepositoryImpl({required OnBoardingLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      await _localDataSource.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      return left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<bool> checkIfUserFirstTimer() async {
    try {
      final result = await _localDataSource.checkIfUserFirstTimer();
      return  Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}

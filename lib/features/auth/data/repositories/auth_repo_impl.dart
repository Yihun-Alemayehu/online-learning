import 'package:dartz/dartz.dart';
import 'package:online_learning/core/enums/update_user.dart';
import 'package:online_learning/core/errors/exception.dart';
import 'package:online_learning/core/errors/failure.dart';
import 'package:online_learning/core/utils/typedef.dart';
import 'package:online_learning/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:online_learning/features/auth/domain/entities/user.dart';
import 'package:online_learning/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl({required AuthRemoteDataSource remoteDataSource}) : _remoteDataSource = remoteDataSource;

  @override
  ResultFuture<void> forgotPassword(String email) async{
    try {
      await _remoteDataSource.forgotPassword(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
    
  }

  @override
  ResultFuture<MyUser> signIn({required String email, required String password}) async{
    try {
      final result = await _remoteDataSource.signIn(email: email, password: password);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> signUp({required String email, required String fullName, required String password}) async{
    try {
       await _remoteDataSource.signUp(email: email, fullName: fullName, password: password);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> updateUser({required UpdateUserAction action, required userData}) async{
    try {
      await _remoteDataSource.updateUser(action: action, userData: userData);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

}
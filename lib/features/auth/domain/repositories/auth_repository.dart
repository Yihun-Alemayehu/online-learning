import 'package:online_learning/core/enums/update_user.dart';
import 'package:online_learning/core/utils/typedef.dart';
import 'package:online_learning/features/auth/domain/entities/user.dart';

abstract class AuthRepository {

  ResultFuture<MyUser> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  ResultFuture<void> forgotPassword(String email);

  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });

}
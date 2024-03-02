import 'package:online_learning/core/enums/update_user.dart';
import 'package:online_learning/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {

  Future<void> forgotPassword(String email);

  Future<MyUserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });

}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  final FirebaseAuth _authClient;
  final FirebaseFirestore _cloudStoreclient;
  final FirebaseStorage _dbClient;

  AuthRemoteDataSourceImpl({required FirebaseAuth authClient, required FirebaseFirestore cloudStoreclient, required FirebaseStorage dbClient}) : _authClient = authClient, _cloudStoreclient = cloudStoreclient, _dbClient = dbClient;

  @override
  Future<void> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<MyUserModel> signIn({required String email, required String password}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signUp({required String email, required String fullName, required String password}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser({required UpdateUserAction action, required userData}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

}
import 'package:equatable/equatable.dart';
import 'package:online_learning/core/usecase/usecase.dart';
import 'package:online_learning/core/utils/typedef.dart';
import 'package:online_learning/features/auth/domain/entities/user.dart';
import 'package:online_learning/features/auth/domain/repositories/auth_repository.dart';

class SignInUsecase extends UsecaseWithParams<MyUser, SignInParams> {
  final AuthRepository _repository;

  SignInUsecase({required AuthRepository repository})
      : _repository = repository;

  @override
  ResultFuture<MyUser> call(SignInParams params) async =>
      await _repository.signIn(email: params.email, password: params.password);
}

class SignInParams extends Equatable {
  final String email;
  final String password;

  const SignInParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

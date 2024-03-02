import 'package:equatable/equatable.dart';
import 'package:online_learning/core/usecase/usecase.dart';
import 'package:online_learning/core/utils/typedef.dart';
import 'package:online_learning/features/auth/domain/repositories/auth_repository.dart';

class SignUpUsecase extends UsecaseWithParams<void, SignUpParams> {
  final AuthRepository _repository;

  SignUpUsecase({required AuthRepository repository})
      : _repository = repository;

  @override
  ResultFuture<void> call(SignUpParams params) async =>
      await _repository.signUp(
          email: params.email,
          fullName: params.fullName,
          password: params.password);
}

class SignUpParams extends Equatable {
  final String fullName;
  final String email;
  final String password;

  const SignUpParams({
    required this.fullName,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [fullName, email, password];
}

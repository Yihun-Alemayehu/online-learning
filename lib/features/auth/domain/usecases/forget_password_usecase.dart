import 'package:equatable/equatable.dart';
import 'package:online_learning/core/usecase/usecase.dart';
import 'package:online_learning/core/utils/typedef.dart';
import 'package:online_learning/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordUsecase extends UsecaseWithParams<void, ForgotPasswordParams> {
  final AuthRepository _repository;

  ForgotPasswordUsecase({required AuthRepository repository})
      : _repository = repository;

  @override
  ResultFuture<void> call(ForgotPasswordParams params) async =>
      await _repository.forgotPassword(params.email);
}

class ForgotPasswordParams extends Equatable {
  final String email;

  const ForgotPasswordParams({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}

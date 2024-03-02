import 'package:equatable/equatable.dart';
import 'package:online_learning/core/enums/update_user.dart';
import 'package:online_learning/core/usecase/usecase.dart';
import 'package:online_learning/core/utils/typedef.dart';
import 'package:online_learning/features/auth/domain/repositories/auth_repository.dart';

class UpdateUserUsecase extends UsecaseWithParams<void, UpdateUserParams> {
  final AuthRepository _repository;

  UpdateUserUsecase({required AuthRepository repository})
      : _repository = repository;

  @override
  ResultFuture<void> call(UpdateUserParams params) async => await _repository
      .updateUser(action: params.action, userData: params.userData);
}

class UpdateUserParams extends Equatable {
  final UpdateUserAction action;
  final dynamic userData;

  const UpdateUserParams({
    required this.action,
    required this.userData,
  });

  @override
  List<Object?> get props => [action, userData];
}

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:online_learning/core/enums/update_user.dart';
import 'package:online_learning/core/errors/failure.dart';
import 'package:online_learning/features/auth/domain/entities/user.dart';
import 'package:online_learning/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:online_learning/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:online_learning/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:online_learning/features/auth/domain/usecases/update_user_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ForgotPasswordUsecase _forgotPasswordUsecase;
  final SignInUsecase _signInUsecase;
  final SignUpUsecase _signUpUsecase;
  final UpdateUserUsecase _updateUserUsecase;

  AuthBloc({
    required ForgotPasswordUsecase forgotPasswordUsecase,
    required SignInUsecase signInUsecase,
    required SignUpUsecase signUpUsecase,
    required UpdateUserUsecase updateUserUsecase,
  })  : _forgotPasswordUsecase = forgotPasswordUsecase,
        _signInUsecase = signInUsecase,
        _signUpUsecase = signUpUsecase,
        _updateUserUsecase = updateUserUsecase,
        super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) {
        emit(AuthLoadingState());
      },
    );
    on<SignInEvent>(_signInHandler);
    on<SignUpEvent>(_signUpHandler);
    on<ForgotPasswordEvent>(_forgotPasswordHandler);
    on<UpdateUserEvent>(_updateUserHandler);
  }

  Future<void> _signInHandler(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signInUsecase.call(
      SignInParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) => emit(
        AuthErrorState(errorMessage: failure.message),
      ),
      (user) => emit(
        SignedInState(user: user),
      ),
    );
  }

  Future<void> _signUpHandler(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signUpUsecase(
      SignUpParams(
          fullName: event.name, email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(AuthErrorState(errorMessage: failure.message)),
      (_) => emit(SignedUpState()),
    );
  }

  Future<void> _forgotPasswordHandler(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _forgotPasswordUsecase(
      ForgotPasswordParams(email: event.email),
    );

    result.fold(
      (failure) => emit(
        AuthErrorState(errorMessage: failure.message),
      ),
      (_) => emit(
        ForgotPasswordState(),
      ),
    );
  }

  Future<void> _updateUserHandler(
    UpdateUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _updateUserUsecase(
      UpdateUserParams(action: event.action, userData: event.userData),
    );

    result.fold(
      (failure) => emit(
        AuthErrorState(errorMessage: failure.message),
      ),
      (_) => emit(
        UserUpdatedState(),
      ),
    );
  }
}

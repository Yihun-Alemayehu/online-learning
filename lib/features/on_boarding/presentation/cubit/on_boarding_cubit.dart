import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:online_learning/features/on_boarding/domain/usecases/cache_first_timer_usecase.dart';
import 'package:online_learning/features/on_boarding/domain/usecases/check_if_user_first_timer_usecase.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  final CacheFirstTimerUsecase _cacheFirstTimer;
  final CheckIfUserFirstTimerUsecase _checkIfUserFirstTimer;
  OnBoardingCubit({
    required CacheFirstTimerUsecase cacheFirstTimer,
    required CheckIfUserFirstTimerUsecase checkIfUserFirstTimer,
  })  : _cacheFirstTimer = cacheFirstTimer,
        _checkIfUserFirstTimer = checkIfUserFirstTimer,
        super(OnBoardingInitialState());

  Future<void> cacheFirstTimer() async {
    emit(CachingFirstTimerState());
    final result = await _cacheFirstTimer();
    result.fold(
        (failure) => emit(OnBoardingErrorState(errorMessage: failure.message)),
        (_) => emit(UserCachedState()));
  }

  Future<void> checkIfUserFirstTimer() async {
    emit(CheckingIfUserIsFirstTimerState());
    final result = await _checkIfUserFirstTimer();
    result.fold(
        (failure) => emit(const OnBoardingStatusState(isFirstTimer: true)),
        (status) => emit(OnBoardingStatusState(isFirstTimer: status)));
  }
}

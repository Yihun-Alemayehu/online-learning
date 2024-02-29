part of 'on_boarding_cubit.dart';

abstract class OnBoardingState extends Equatable {
  const OnBoardingState();

  @override
  List<Object> get props => [];
}

class OnBoardingInitialState extends OnBoardingState {}

class CachingFirstTimerState extends OnBoardingState {}

class CheckingIfUserIsFirstTimerState extends OnBoardingState {}

class UserCachedState extends OnBoardingState {}

class OnBoardingStatusState extends OnBoardingState {
  final bool isFirstTimer;

  const OnBoardingStatusState({required this.isFirstTimer});

  @override
  List<bool> get props => [isFirstTimer];
}

class OnBoardingErrorState extends OnBoardingState {
  final String errorMessage;

  const OnBoardingErrorState({required this.errorMessage});

  @override
  List<String> get props => [errorMessage];
}



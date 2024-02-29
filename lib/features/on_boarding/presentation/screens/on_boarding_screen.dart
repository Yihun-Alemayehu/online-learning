import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_learning/core/common/views/loading_view.dart';
import 'package:online_learning/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static const routeName = '/';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  @override
  void initState() {
    super.initState();
    context.read<OnBoardingCubit>().checkIfUserFirstTimer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingState>(
      listener: (context, state) {
        if (state is OnBoardingStatusState) {
          Navigator.pushReplacementNamed(context, '/home');
        }else if(state is UserCachedState) {
          // push to appropriate screen
          
        }
      },
      builder: (context, state) {
        if(state is CheckingIfUserIsFirstTimerState || state is CachingFirstTimerState){
          return const LoadingView();
        }
      },
    );
  }
}

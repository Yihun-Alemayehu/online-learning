import 'package:flutter/material.dart';
import 'package:online_learning/core/common/views/page_under_construction.dart';
import 'package:online_learning/core/services/injection_container.dart';
import 'package:online_learning/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:online_learning/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OnBoardingScreen.routeName:
      return _pageRouteBuilder(
        (_) =>  BlocProvider<OnBoardingCubit>(
          create: (_) => sl<OnBoardingCubit>(),
          child: const OnBoardingScreen(),
        ),
        settings: settings,
      );
    default:
      return _pageRouteBuilder(
        (_) =>  BlocProvider<OnBoardingCubit>(
          create: (_) => sl<OnBoardingCubit>(),
          child: const OnBoardingScreen(),
        ),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageRouteBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}

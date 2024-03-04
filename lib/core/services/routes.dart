import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_learning/core/common/app/provider/user_provider.dart';
import 'package:online_learning/core/common/views/page_under_construction.dart';
import 'package:online_learning/core/services/injection_container.dart';
import 'package:online_learning/features/auth/domain/entities/user.dart';
import 'package:online_learning/features/on_boarding/data/datasources/onboarding_local_data_source.dart';
import 'package:online_learning/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:online_learning/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      final prefs = sl<SharedPreferences>();
      return _pageRouteBuilder(
        (context) {
        if (prefs.getBool(kFirstTimerKey) ?? true) {
          BlocProvider<OnBoardingCubit>(
            create: (_) => sl<OnBoardingCubit>(),
            child: const OnBoardingScreen(),
          );
        } else if (sl<FirebaseAuth>().currentUser != null) {
          final user = sl<FirebaseAuth>().currentUser!;
          final myUser = MyUser(
            uid: user.uid,
            email: user.email ?? '',
            points: 0,
            fullName: user.displayName ?? '',
          );
          context.read<UserProvider>().initUser(myUser);
        };
        
      }
          settings: settings,
          );
    default:
      return _pageRouteBuilder(
        (_) => BlocProvider<OnBoardingCubit>(
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

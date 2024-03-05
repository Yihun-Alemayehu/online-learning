import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_learning/core/res/colors.dart';
import 'package:online_learning/core/res/fonts.dart';
import 'package:online_learning/core/services/injection_container.dart';
import 'package:online_learning/core/services/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:online_learning/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:online_learning/features/auth/presentation/screens/home_screen.dart';
import 'package:online_learning/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:online_learning/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:online_learning/features/dashboard/presentation/screens/dashboard.dart';
import 'package:online_learning/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:online_learning/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Education',
      theme: ThemeData(
        fontFamily: Fonts.poppins,
        colorScheme: ColorScheme.fromSwatch(accentColor: Colours.primaryColour),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
        ),
      ),
      // onGenerateRoute: generateRoute,
      routes: {
        '/': (context) => BlocProvider(
              create: (context) => sl<OnBoardingCubit>(),
              child: const OnBoardingScreen(),
            ),
        '/home':(context) => const HomeScreen(),
        '/dashboard': (context) => BlocProvider(
              create: (context) => sl<AuthBloc>(),
              child: const Dashboard(),
            ),
        '/sign-in': (context) => BlocProvider(
              create: (context) => sl<AuthBloc>(),
              child: const SignInScreen(),
            ),
        '/sign-up': (context) => BlocProvider(
              create: (context) => sl<AuthBloc>(),
              child: const SignUpScreen(),
            ),
      },
    );
  }
}

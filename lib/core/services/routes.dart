// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:online_learning/core/common/app/provider/user_provider.dart';
// import 'package:online_learning/core/services/injection_container.dart';
// import 'package:online_learning/features/auth/domain/entities/user.dart';
// import 'package:online_learning/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:online_learning/features/auth/presentation/screens/sign_in_screen.dart';
// import 'package:online_learning/features/auth/presentation/screens/sign_up_screen.dart';
// import 'package:online_learning/features/dashboard/presentation/screens/dashboard.dart';
// import 'package:online_learning/features/on_boarding/data/datasources/onboarding_local_data_source.dart';
// import 'package:online_learning/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
// import 'package:online_learning/features/on_boarding/presentation/screens/on_boarding_screen.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// Route<dynamic> generateRoute(RouteSettings settings) {
//   switch (settings.name) {
//     case '/':
//       final prefs = sl<SharedPreferences>();
//       return _pageRouteBuilder(
//         (context) {
//           if (prefs.getBool(kFirstTimerKey) ?? true) {
//             return BlocProvider<OnBoardingCubit>(
//               create: (_) => sl<OnBoardingCubit>(),
//               child: const OnBoardingScreen(),
//             );
//           } else if (sl<FirebaseAuth>().currentUser != null) {
//             final user = sl<FirebaseAuth>().currentUser!;
//             final myUser = MyUser(
//               uid: user.uid,
//               email: user.email ?? '',
//               points: 0,
//               fullName: user.displayName ?? '',
//             );
//             context.read<UserProvider>().initUser(myUser);
//             return const Dashboard();
//           }
//           return BlocProvider<AuthBloc>(
//             create: (context) => sl<AuthBloc>(),
//             child: const SignInScreen(),
//           );
//         },
//         settings: settings,
//       );
//     case SignInScreen.routeName:
//       return _pageRouteBuilder(
//           (_) => BlocProvider<AuthBloc>(
//                 create: (context) => sl<AuthBloc>(),
//                 child: const SignInScreen(),
//               ),
//           settings: settings);
//     case SignUpScreen.routeName:
//       return _pageRouteBuilder(
//           (_) => BlocProvider<AuthBloc>(
//                 create: (context) => sl<AuthBloc>(),
//                 child: const SignUpScreen(),
//               ),
//           settings: settings);
//     case Dashboard.routeName:
//       return _pageRouteBuilder(
//         (_) => const Dashboard(),
//         settings: settings,
//       );
//     default:
//       return _pageRouteBuilder(
//         (_) => BlocProvider<OnBoardingCubit>(
//           create: (_) => sl<OnBoardingCubit>(),
//           child: const OnBoardingScreen(),
//         ),
//         settings: settings,
//       );
//   }
// }

// PageRouteBuilder<dynamic> _pageRouteBuilder(
//   Widget Function(BuildContext) page, {
//   required RouteSettings settings,
// }) {
//   return PageRouteBuilder(
//     settings: settings,
//     transitionsBuilder: (_, animation, __, child) => FadeTransition(
//       opacity: animation,
//       child: child,
//     ),
//     pageBuilder: (context, _, __) => page(context),
//   );
// }

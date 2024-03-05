import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_learning/core/common/app/provider/user_provider.dart';
import 'package:online_learning/core/common/widgets/gradient_background.dart';
import 'package:online_learning/core/res/fonts.dart';
import 'package:online_learning/core/res/media_files.dart';
import 'package:online_learning/core/utils/snackbar.dart';
import 'package:online_learning/features/auth/presentation/bloc/auth_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  // static const routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          MySnackBar.showSnackBar(context, state.errorMessage);
        } else if (state is SignedInState) {
          context.read<UserProvider>().initUser(state.user);
          Navigator.pushReplacementNamed(context, '/dashboard');
        }
      },
      builder: (context, state) {
        return const GradientBackground(
          image: MediaFiles.onBoardingBackground,
          child: SafeArea(child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text('Easy to learn, Discover more skills',
                  style: TextStyle(
                    fontFamily: Fonts.aeonik,
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),)
                ],
              ),
            ),
          )),
        );
      },
    ));
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_learning/core/common/app/provider/user_provider.dart';
import 'package:online_learning/core/common/widgets/gradient_background.dart';
import 'package:online_learning/core/res/colors.dart';
import 'package:online_learning/core/res/fonts.dart';
import 'package:online_learning/core/res/media_files.dart';
import 'package:online_learning/core/utils/snackbar.dart';
import 'package:online_learning/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:online_learning/features/auth/presentation/widgets/sign_in_form.dart';

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
        return GradientBackground(
          image: MediaFiles.onBoardingBackground,
          child: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    'Easy to learn, Discover more skills',
                    style: TextStyle(
                      fontFamily: Fonts.aeonik,
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Sign In to your account'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/sign-up');
                        },
                        child: const Text('Register now'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SignInForm(
                    emailController: _emailController,
                    passwordController: _passwordController,
                    formKey: formKey,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgot-password');
                      },
                      child: const Text(
                        'Forgot password ?',
                        style: TextStyle(
                          color: Colours.primaryColour,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 17,
                      ),
                      backgroundColor: Colours.primaryColour,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      // FocusManager.instance.primaryFocus?.unfocus();
                      // FirebaseAuth.instance.currentUser?.reload();
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              SignInEvent(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim()),
                            );
                      }
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: Fonts.aeonik,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
        );
      },
    ));
  }
}

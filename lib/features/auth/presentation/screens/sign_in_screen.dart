import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  // static const routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sign In Screen'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context,'/');
              },
              child: const Text('Go to OnBoarding Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
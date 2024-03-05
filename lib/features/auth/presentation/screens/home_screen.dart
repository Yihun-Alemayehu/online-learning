import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('data'),
            MaterialButton(
              onPressed: (){
              Navigator.pushNamed(context, '/sign-in');
            },
            child: const Text('Go to Sign In'),)
        
          ],
        ),
      ),
    );
  }
}
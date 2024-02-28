import 'package:flutter/material.dart';
import 'package:online_learning/core/res/colors.dart';
import 'package:online_learning/core/res/fonts.dart';
import 'package:online_learning/core/services/routes.dart';
import 'package:online_learning/features/on_boarding/presentation/screens/on_boarding_screen.dart';

void main() {
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
      onGenerateRoute: generateRoute,
    );
  }
}


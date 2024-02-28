import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:online_learning/core/res/media_files.dart';

class PageUnderConstructionScreen extends StatelessWidget {
  const PageUnderConstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(MediaFiles.onBoardingBackground),
          fit: BoxFit.cover,
        )),
        child: SafeArea(
          child: Center(
            child: LottieBuilder(
              lottie: AssetLottie(MediaFiles.pageUnderConstruction),
            ),
          ),
        ),
      ),
    );
  }
}

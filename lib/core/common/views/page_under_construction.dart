import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:online_learning/core/common/widgets/gradient_background.dart';
import 'package:online_learning/core/res/media_files.dart';

class PageUnderConstructionScreen extends StatelessWidget {
  const PageUnderConstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        image: MediaFiles.onBoardingBackground,
        child: Center(
          child: LottieBuilder(
            lottie: AssetLottie(MediaFiles.pageUnderConstruction),
          ),
        ),
      ),
    );
  }
}

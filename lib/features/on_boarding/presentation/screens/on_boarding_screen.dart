import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_learning/core/common/views/loading_view.dart';
import 'package:online_learning/core/common/widgets/gradient_background.dart';
import 'package:online_learning/core/res/media_files.dart';
import 'package:online_learning/features/on_boarding/domain/entities/page_content.dart';
import 'package:online_learning/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:online_learning/features/on_boarding/presentation/widgets/on_boarding_body.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  // static const routeName = '/';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // final pageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<OnBoardingCubit>().checkIfUserFirstTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        image: MediaFiles.onBoardingBackground,
        child: BlocConsumer<OnBoardingCubit, OnBoardingState>(
          listener: (context, state) {
            if (state is OnBoardingStatusState) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state is UserCachedState) {
              Navigator.pushReplacementNamed(context, '/');
            }
          },
          builder: (context, state) {
            if (state is CheckingIfUserIsFirstTimerState ||
                state is CachingFirstTimerState) {
              return const LoadingView();
            }
            return Stack(
              children: [
                // PageView(
                //   controller: pageController,
                //   children: [
                //     OnBoardingBody(pageContent: PageContent.first()),
                //     OnBoardingBody(pageContent: PageContent.second()),
                //     OnBoardingBody(pageContent: PageContent.third()),
                //   ],
                // ),
                // Align(
                //   alignment: const Alignment(0, 0.04),
                //   child: SmoothPageIndicator(
                //     controller: pageController,
                //     count: 3,
                //     onDotClicked: (index){
                //       pageController.animateToPage(
                //         index,
                //         duration: const Duration(milliseconds: 500),
                //         curve: Curves.easeInOut,
                //       );
                //     },
                //     effect: const WormEffect(
                //       dotColor: Colors.white,
                //       activeDotColor: Colours.primaryColour,
                //       dotHeight: 15,
                //       dotWidth: 15,
                //       spacing: 20,
                      
                //     ),
                //   ),
                // )
                OnBoardingBody(pageContent: PageContent.first()),
              ],
            );
          },
        ),
      ),
    );
  }
}

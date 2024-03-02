import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_learning/core/res/colors.dart';
import 'package:online_learning/core/res/fonts.dart';
import 'package:online_learning/features/on_boarding/domain/entities/page_content.dart';
import 'package:online_learning/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';

class OnBoardingBody extends StatelessWidget {
  final PageContent pageContent;
  const OnBoardingBody({super.key, required this.pageContent});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          pageContent.image,
          height: MediaQuery.of(context).size.height * 0.4,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.all(20).copyWith(bottom: 0),
          child: Column(
            children: [
              Text(
                pageContent.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: Fonts.aeonik,
                  fontWeight: FontWeight.w600,
                  fontSize: 40,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                pageContent.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
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
                    context.read<OnBoardingCubit>().cacheFirstTimer();
                  },
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: Fonts.aeonik,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
        )
      ],
    );
  }
}

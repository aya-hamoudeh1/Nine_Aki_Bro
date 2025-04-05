import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_aki_bro/views/onboarding/widgets/dot_navigation.dart';
import 'package:nine_aki_bro/views/onboarding/widgets/next_button.dart';
import 'package:nine_aki_bro/views/onboarding/widgets/onboarding_page.dart';
import 'package:nine_aki_bro/views/onboarding/widgets/skip_button.dart';
import 'cubit/onboarding_cubit.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<OnBoardingCubit>();
          return Scaffold(
            body: Stack(
              children: [
                /// Horizontal Scrollable pages
                PageView(
                  controller: cubit.pageController,
                  onPageChanged: (index) {
                    cubit.goToPage(index);
                  },
                  children: const [
                    OnBoardingPage(
                      image: 'assets/images/test1.jpg',
                      title: 'Welcome to Nine Aki Bro',
                      subTitle:
                          'Enjoy an innovative experience with all the features we offer. Let us help you discover a whole new world of convenience',
                    ),
                    OnBoardingPage(
                      image: 'assets/images/test2.jpg',
                      title: 'Discover Our Unique Features',
                      subTitle:
                          'Explore tools and functions that make your life easier and faster. Everything you need is at your fingertips.',
                    ),
                    OnBoardingPage(
                      image: 'assets/images/test1.jpg',
                      title: 'Get Started Now!',
                      subTitle:
                          'The first step starts here. Let us take you on a journey to explore everything Nine Aki Bro has to offer',
                    ),
                  ],
                ),

                /// Skip Button
                const OnBoardingSkip(),

                /// Dot Navigation SmoothPageIndicator
                const OnBoardingDotNavigation(),

                /// Circular Button
                const OnBoardingNextButton(),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_aki_bro/onboarding/cubit/onboarding_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnBoardingCubit>();

    return Positioned(
      bottom:40 ,
      left: 20,
      child:BlocBuilder<OnBoardingCubit,int>(
        builder: (context, pageIndex) {
          return SmoothPageIndicator(
            effect: ExpandingDotsEffect(
              activeDotColor: kPrimaryColor,
              dotHeight: 6,
            ),
            controller: cubit.pageController,
            count: 3,
            onDotClicked: (index) {
              cubit.goToPage(index);
            },
          );
        },
      )

    );
  }
}
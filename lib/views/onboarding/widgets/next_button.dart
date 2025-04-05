import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/constants/colors.dart';
import '../../auth/ui/login/login_view.dart';
import '../cubit/onboarding_cubit.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnBoardingCubit>();

    return Positioned(
      right: 20,
      bottom: 40,
      child: BlocBuilder<OnBoardingCubit, int>(
        builder: (context, pageIndex) {
          return ElevatedButton(
            onPressed: () {
              if (pageIndex == 2) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              } else {
                cubit.nextPage();
              }
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: TColors.primary,
            ),
            child: const Icon(
              Iconsax.arrow_right_3,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}

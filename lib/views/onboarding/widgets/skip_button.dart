import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../auth/ui/login/login_view.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      right: 20,
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        },
        child: const Text(
          "Skip",
          style: TextStyle(
            color: TColors.primary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

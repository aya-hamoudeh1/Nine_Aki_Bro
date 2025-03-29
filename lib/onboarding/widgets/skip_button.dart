import 'package:flutter/material.dart';
import 'package:nine_aki_bro/constants.dart';

import '../../auth/login_screen.dart';

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
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        },
        child: Text(
          "Skip",
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

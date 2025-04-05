import 'package:flutter/material.dart';
import 'package:nine_aki_bro/core/helpers/helper_functions.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/constants/text_string.dart';

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 150,
          image: AssetImage(
            dark
                ? 'assets/logos/logo_test.png'
                : 'assets/logos/logo_test_primary_color.png',
          ),
        ),
        Text(
          TTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: dark ? Colors.white : TColors.primary,
              ),
        ),
        const SizedBox(
          height: TSizes.sm,
        ),
        Text(
          TTexts.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

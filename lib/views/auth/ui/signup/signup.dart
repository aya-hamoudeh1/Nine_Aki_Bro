import 'package:flutter/material.dart';
import 'package:nine_aki_bro/views/auth/ui/signup/widgets/sign_up_form.dart';

import '../../../../core/widgets/login_signup/form_divider.dart';
import '../../../../core/widgets/login_signup/social_button.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/constants/text_string.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                TTexts.signUpTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Form
              const TSignUpForm(),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Divider
              const TFormDivider(dividerText: TTexts.orSignInWith),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Footer
              const TSocialButtons(),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

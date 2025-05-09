import 'package:flutter/material.dart';
import 'package:nine_aki_bro/views/auth/ui/login/widgets/login_form.dart';
import 'package:nine_aki_bro/views/auth/ui/login/widgets/login_header.dart';
import '../../../../core/widgets/login_signup/form_divider.dart';
import '../../../../core/widgets/login_signup/social_button.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/constants/text_string.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              /// Logo , Title & Sub-Title
              TLoginHeader(),
              /// Form
              TLoginForm(),
              /// Divider
              TFormDivider(
                dividerText: TTexts.orSignInWith,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Footer
              TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nine_aki_bro/features/auth/signup/widgets/term_and_conditions_box.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_string.dart';
import '../../bloc/auth_bloc.dart';

class TSignUpForm extends StatefulWidget {
  const TSignUpForm({
    super.key,
  });

  @override
  State<TSignUpForm> createState() => _TSignUpFormState();
}

class _TSignUpFormState extends State<TSignUpForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  //expand : false,
                  decoration: const InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(
                width: TSizes.spaceBtwInputField,
              ),
              Expanded(
                child: TextFormField(
                  //expand : false,
                  decoration: const InputDecoration(
                    labelText: TTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputField,
          ),

          /// Username
          TextFormField(
            //expand : false,
            decoration: const InputDecoration(
              labelText: TTexts.userName,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputField,
          ),

          /// Email
          TextFormField(
            //expand : false,
            decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputField,
          ),

          /// Phone Number
          TextFormField(
            //expand : false,
            decoration: const InputDecoration(
              labelText: TTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputField,
          ),

          /// Password
          TextFormField(
            obscureText: true,
            //expand : false,
            decoration: const InputDecoration(
              labelText: TTexts.password,
              prefixIcon: Icon(Iconsax.password_check),
              suffixIcon: Icon(Iconsax.eye_slash),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          /// Terms&Conditions checkbox
          const TTermAndConditionsBox(),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          /// Sign Up Button
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(TTexts.createAccount),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

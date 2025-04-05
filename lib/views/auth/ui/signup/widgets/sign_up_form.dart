import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nine_aki_bro/views/auth/logic/authentication_cubit.dart';
import 'package:nine_aki_bro/views/auth/ui/signup/widgets/term_and_conditions_box.dart';
import 'package:nine_aki_bro/views/nav_bar/ui/navigation_menu.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../../core/constants/text_string.dart';
import '../../../../../core/helpers/show_msg.dart';

class TSignUpForm extends StatefulWidget {
  const TSignUpForm({
    super.key,
  });

  @override
  State<TSignUpForm> createState() => _TSignUpFormState();
}

class _TSignUpFormState extends State<TSignUpForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const NavigationMenu(),
            ),
          );
        }
        if (state is SignUpError) {
          showMsg(context, state.message);
        }
      },
      builder: (context, state) {
        AuthenticationCubit cubit = context.read<AuthenticationCubit>();
        return Form(
          key: _formKey,
          child: state is LoginLoading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                           controller: _firstNameController,
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
                            controller: _lastNameController,
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

                    /// Age
                    TextFormField(
                      //expand : false,
                      decoration: const InputDecoration(
                        labelText: TTexts.age,
                        prefixIcon: Icon(Iconsax.personalcard),
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwInputField,
                    ),

                    /// Age
                    TextFormField(
                      //expand : false,
                      decoration: const InputDecoration(
                        labelText: TTexts.age,
                        prefixIcon: Icon(Iconsax.personalcard),
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwInputField,
                    ),

                    /// Email
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: TTexts.email,
                        prefixIcon: Icon(Iconsax.direct),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter your email' : null,
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
                      controller: _passwordController,
                      obscureText: true,
                      //expand : false,
                      decoration:  InputDecoration(
                        labelText: TTexts.password,
                        prefixIcon: const Icon(Iconsax.password_check),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordHidden = !isPasswordHidden;
                            });
                          },
                          icon: Icon(isPasswordHidden
                              ? Iconsax.eye_slash
                              : Iconsax.eye),
                        ),
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
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            cubit.signUp(
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          }
                        },
                        child: const Text(TTexts.createAccount),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

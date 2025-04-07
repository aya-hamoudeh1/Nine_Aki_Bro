import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nine_aki_bro/core/helpers/show_msg.dart';
import 'package:nine_aki_bro/views/auth/logic/cubit/authentication_cubit.dart';
import 'package:nine_aki_bro/views/auth/ui/password_configuration/reset_password.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/constants/text_string.dart';
import 'package:email_validator/email_validator.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is PasswordResetSuccess) {
          emailController.clear();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ResetPassword(),
            ),
          );
        } else if (state is PasswordResetError) {
          showMsg(context, 'There was some error');
        }
      },
      builder: (context, state) {
        AuthenticationCubit cubit = context.read<AuthenticationCubit>();
        return Scaffold(
          appBar: AppBar(),
          body: state is PasswordResetLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Headings
                        Text(
                          TTexts.forgetPasswordTitle,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),

                        const SizedBox(height: TSizes.spaceBtwItems),

                        Text(
                          TTexts.forgetPasswordSubTitle,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),

                        const SizedBox(height: TSizes.spaceBtwSections * 2),

                        /// Text field
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!EmailValidator.validate(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: TTexts.email,
                            prefixIcon: Icon(Iconsax.direct_right),
                          ),
                        ),

                        const SizedBox(height: TSizes.spaceBtwSections),

                        /// Submit Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.resetPassword(
                                    email: emailController.text);
                              }
                            },
                            child: const Text(TTexts.submit),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}

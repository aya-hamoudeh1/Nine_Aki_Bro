import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nine_aki_bro/core/constants/colors.dart';
import 'package:nine_aki_bro/core/helpers/helper_functions.dart';
import 'package:nine_aki_bro/core/helpers/show_msg.dart';
import 'package:nine_aki_bro/views/auth/logic/authentication_cubit.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/constants/text_string.dart';
import '../../../../nav_bar/ui/navigation_menu.dart';
import '../../password_configuration/forget_password.dart';
import '../../signup/signup.dart';

class TLoginForm extends StatefulWidget {
  const TLoginForm({super.key});

  @override
  State<TLoginForm> createState() => _TLoginFormState();
}

class _TLoginFormState extends State<TLoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is LoginSuccess ) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const NavigationMenu(),
            ),
          );
        }
        if (state is LoginError) {
          showMsg(context, state.message);
        }
      },
      builder: (context, state) {
        AuthenticationCubit cubit = context.read<AuthenticationCubit>();
        return Form(
          key: _formKey,
          child: state is LoginLoading
              ? const CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: TSizes.spaceBtwSections),
                  child: Column(
                    children: [
                      /// Email
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.direct_right),
                          labelText: TTexts.email,
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter your email' : null,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputField),

                      /// Password
                      TextFormField(
                        controller: passwordController,
                        obscureText: isPasswordHidden,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.password_check),
                          labelText: TTexts.password,
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
                        validator: (value) => value!.length < 6
                            ? 'Password must be at least 6 characters long'
                            : null,
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputField / 2),

                      /// Remember Me & Forget Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Remember Me
                          Row(
                            children: [
                              Checkbox(
                                value: true,
                                onChanged: (value) {},
                              ),
                              const Text(TTexts.rememberMe),
                            ],
                          ),

                          /// Forget Password
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgetPassword(),
                                ),
                              );
                            },
                            child: const Text(TTexts.forgetPassword),
                          ),
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      /// Sign In Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.login(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          child: const Text(TTexts.sighIn),
                        ),
                      ),

                      const SizedBox(height: TSizes.spaceBtwItems),

                      /// Create Account Button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: Text(
                            TTexts.createAccount,
                            style: TextStyle(
                              color: dark ? Colors.white : TColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

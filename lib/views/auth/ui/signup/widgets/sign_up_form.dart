import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nine_aki_bro/core/helpers/validators.dart';
import 'package:nine_aki_bro/views/auth/logic/cubit/authentication_cubit.dart';
import 'package:nine_aki_bro/views/auth/ui/signup/widgets/age_group_dropdown.dart';
import 'package:nine_aki_bro/views/auth/ui/signup/widgets/skin_tone_selector.dart';
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isPasswordHidden = true;
  String? selectedAgeGroup;
  Color? selectedSkinTone;

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
          child: Column(
            children: [
              /// Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: TTexts.name,
                  prefixIcon: Icon(Iconsax.user),
                ),
                validator: TValidator.validateName,
              ),
              const SizedBox(height: TSizes.spaceBtwInputField),

              /// Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: TTexts.email,
                  prefixIcon: Icon(Iconsax.direct),
                ),
                validator: TValidator.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: TSizes.spaceBtwInputField),

              /// Password
              TextFormField(
                controller: _passwordController,
                obscureText: isPasswordHidden,
                decoration: InputDecoration(
                  labelText: TTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                    icon: Icon(
                        isPasswordHidden ? Iconsax.eye_slash : Iconsax.eye),
                  ),
                ),
                validator: TValidator.validatePassword,
              ),
              const SizedBox(height: TSizes.spaceBtwInputField),

              /// Phone Number
              TextFormField(
                controller: _phoneController,
                //expand : false,
                decoration: const InputDecoration(
                  labelText: TTexts.phoneNo,
                  prefixIcon: Icon(Iconsax.call),
                ),
                validator: TValidator.validatePhoneNumber,
              ),
              const SizedBox(height: TSizes.spaceBtwInputField),

              /// Address
              TextFormField(
                controller: _addressController,
                //expand : false,
                decoration: const InputDecoration(
                  labelText: TTexts.address,
                  prefixIcon: Icon(Iconsax.location),
                ),
                validator: TValidator.validateAddress,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              Text(
                'Age and skin tone help us suggest the best outfits for you :',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: TSizes.spaceBtwInputField),

              /// Age
              AgeGroupDropdown(
                selectedValue: selectedAgeGroup,
                onChanged: (p0) {
                  setState(() {
                    selectedAgeGroup = p0;
                  });
                },
              ),
              const SizedBox(height: TSizes.spaceBtwInputField),

              /// Skin Color
              SkinToneSelector(
                selectedColor: selectedSkinTone,
                onColorSelected: (color) {
                  setState(() {
                    selectedSkinTone = color;
                  });
                },
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Terms&Conditions checkbox
              const TTermAndConditionsBox(),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Sign Up Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state is LoginLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            cubit.signUp(
                              name: _nameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                              phoneNumber: _phoneController.text,
                              address: _addressController.text,
                              ageGroup: selectedAgeGroup ?? '',
                              skinTone: selectedSkinTone,
                            );
                          }
                        },
                  child: state is SignUpLoading
                      ? const Center(child: CircularProgressIndicator())
                      : const Text(TTexts.createAccount),
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}

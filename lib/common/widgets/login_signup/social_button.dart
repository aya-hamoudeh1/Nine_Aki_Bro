import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/helpers/show_msg.dart';
import '../../../views/auth/logic/authentication_cubit.dart';
import '../../../views/nav_bar/ui/navigation_menu.dart';

class TSocialButtons extends StatelessWidget {
  const TSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
      if (state is GoogleSignInSuccess) {
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
    }, builder: (context, state) {
      AuthenticationCubit cubit = context.read<AuthenticationCubit>();
      return state is GoogleSignInLoading
          ? const CircularProgressIndicator()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: TColors.grey),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: IconButton(
                    onPressed: () => cubit.googleSignIn(),
                    icon: const Image(
                      width: TSizes.iconMd,
                      height: TSizes.iconMd,
                      image: AssetImage('assets/logos/google_logo.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: TColors.grey),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Image(
                      width: TSizes.iconMd,
                      height: TSizes.iconMd,
                      image: AssetImage('assets/logos/Facebook_Logo.png'),
                    ),
                  ),
                ),
              ],
            );
    });
  }
}

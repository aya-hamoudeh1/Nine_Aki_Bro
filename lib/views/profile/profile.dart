import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_aki_bro/views/auth/logic/cubit/authentication_cubit.dart';
import 'package:nine_aki_bro/views/auth/ui/login/login_view.dart';
import 'package:nine_aki_bro/views/profile/widgets/profile_menu.dart';
import '../../core/widgets/appbar/appbar.dart';
import '../../core/widgets/images/t_circular_image.dart';
import '../../core/widgets/texts/section_heading.dart';
import '../../core/constants/sizes.dart';
import '../auth/logic/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
              listener: (context, state) {
            if (state is LogoutSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            }
          }, builder: (context, state) {
            UserDataModel? userDataModel =
                context.read<AuthenticationCubit>().userDataModel;
            AuthenticationCubit cubit = context.read<AuthenticationCubit>();
            return state is LogoutLoading || state is GetUserDataLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      /// App Bar
                      TAppBar(
                        showBackArrow: true,
                        title: Text(
                          'Profile',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),

                      /// Profile Picture
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            const TCircularImage(
                              image: "assets/images/user.png",
                              height: 80,
                              width: 80,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text("Change Profile Picture"),
                            ),
                          ],
                        ),
                      ),

                      /// Details
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      const Divider(),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      /// Heading Profile Info
                      const TSectionHeading(
                        title: "Profile Information",
                        showActionButton: false,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      TProfileMenu(
                        onPressed: () {},
                        title: "Name",
                        value: userDataModel?.name ?? "User Name",
                      ),
                      TProfileMenu(
                        onPressed: () {},
                        title: "E-Mail",
                        value: userDataModel?.email ?? 'User Email',
                      ),

                      const SizedBox(height: TSizes.spaceBtwItems),
                      const Divider(),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      /// Heading Personal Info
                      const TSectionHeading(
                        title: "Personal Information",
                        showActionButton: false,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      TProfileMenu(
                        onPressed: () {},
                        title: "Phone Number",
                        value:
                            userDataModel?.phoneNumber ?? "User Phone Number",
                      ),
                      TProfileMenu(
                        onPressed: () {},
                        title: "Address",
                        value: userDataModel?.address ?? "User Address",
                      ),
                      const Divider(),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      Center(
                        child: state is LogoutLoading
                            ? const Center(child: CircularProgressIndicator())
                            : TextButton(
                                onPressed: () async {
                                  await cubit.signOut();
                                },
                                child: const Text(
                                  "Logout",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  );
          }),
        ),
      ),
    );
  }
}

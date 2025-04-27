import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nine_aki_bro/core/helpers/helper_functions.dart';
import '../../core/widgets/appbar/appbar.dart';
import '../../core/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../core/widgets/list_tiles/settings_menu_tile.dart';
import '../../core/widgets/list_tiles/user_profile_tile.dart';
import '../../core/widgets/texts/section_heading.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/sizes.dart';
import '../address/address.dart';
import '../order/order.dart';
import '../profile/profile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.dark : TColors.light,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// AppBar
                  TAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: TColors.white),
                    ),
                  ),

                  /// User Profile Card
                  TUserProfileTile(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// Account Setting
                  TSectionHeading(
                    title: "Account Settings",
                    textColor: dark ? TColors.white : TColors.primary,
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  TSettingMenuTile(
                    icon: Iconsax.safe_home,
                    title: "My Addresses",
                    subTitle: "Set shopping delivery address",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserAddressScreen(),
                        ),
                      );
                    },
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: "My Cart",
                    subTitle: "Add, remove products and move to checkout",
                    onTap: () {},
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.bag_tick,
                    title: "My Order",
                    subTitle: "In-progress and Completed Orders",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderScreen(),
                        ),
                      );
                    },
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.bank,
                    title: "Bank Account",
                    subTitle: "Withdraw balance to registered bank account",
                    onTap: () {},
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.discount_shape,
                    title: "My Coupons",
                    subTitle: "List of all the discounted coupons",
                    onTap: () {},
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.notification,
                    title: "Notifications",
                    subTitle: "Set any kind of notification message",
                    onTap: () {},
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.security_card,
                    title: "Account Privacy",
                    subTitle: "Manage data usage and connected accounts",
                    onTap: () {},
                  ),

                  /// App Settings
                  const SizedBox(height: TSizes.spaceBtwSections),
                  TSectionHeading(
                    title: "App Settings",
                    textColor: dark ? TColors.white : TColors.primary,
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const TSettingMenuTile(
                      icon: Iconsax.document_upload,
                      title: "Load Data",
                      subTitle: "Upload Data to Your Cloud Firebase"),
                  TSettingMenuTile(
                    icon: Iconsax.location,
                    title: "Geolocation",
                    subTitle: "Set recommendation based on location",
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.security_user,
                    title: "Safe Mode",
                    subTitle: "Search result is safe for all ages",
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.image,
                    title: "HD Images Quality",
                    subTitle: "Set image quality to be seen",
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

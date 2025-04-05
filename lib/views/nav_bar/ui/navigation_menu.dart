import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nine_aki_bro/core/constants/colors.dart';
import 'package:nine_aki_bro/views/home/ui/home_view.dart';
import 'package:nine_aki_bro/views/nav_bar/logic/navigation_cubit.dart';
import 'package:nine_aki_bro/views/settings/settings.dart';
import 'package:nine_aki_bro/views/store/store.dart';
import 'package:nine_aki_bro/views/wishlist/wishlist.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, selectedIndex) {
          return Scaffold(
            body: _getPage(selectedIndex),
            bottomNavigationBar: Container(
              color: TColors.primary,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 8,
                ),
                child: GNav(
                  rippleColor: TColors.primary,
                  hoverColor: TColors.primary,
                  curve: Curves.easeInOutExpo,
                  duration: const Duration(milliseconds: 400),
                  gap: 8,
                  color: TColors.grey,
                  activeColor: Colors.white,
                  tabBackgroundColor: TColors.darkerGrey,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  selectedIndex: selectedIndex,
                  onTabChange: (index) {
                    context.read<NavigationCubit>().changeTab(index);
                  },
                  tabs: const [
                    GButton(
                      icon: Iconsax.home,
                      text: "Home",
                    ),
                    GButton(
                      icon: Iconsax.shop,
                      text: "Store",
                    ),
                    GButton(
                      icon: Iconsax.heart,
                      text: "Wishlist",
                    ),
                    GButton(
                      icon: Iconsax.user,
                      text: "Profile",
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _getPage(int index) {
  switch (index) {
    case 0:
      return const HomeView();
    case 1:
      return const StoreScreen();
    case 2:
      return const FavoriteScreen();
    case 3:
      return const SettingScreen();
    default:
      return const HomeView();
  }
}

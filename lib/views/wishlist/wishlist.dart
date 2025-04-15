import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nine_aki_bro/views/nav_bar/ui/navigation_menu.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/icons/t_circular_icon.dart';
import '../../common/widgets/layouts/grid_layout.dart';
import '../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../core/constants/sizes.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'WishList',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcon(
            icon: Iconsax.add,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NavigationMenu(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        // child: Padding(
        //   padding: const EdgeInsets.all(TSizes.defaultSpace),
        //   child: Column(
        //     children: [
        //       TGridLayout(
        //         itemCount: 6,
        //         itemBuilder: (_, index) => const TProductCardVertical(),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}

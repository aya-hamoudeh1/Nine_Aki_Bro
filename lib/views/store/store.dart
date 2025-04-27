import 'package:flutter/material.dart';
import 'package:nine_aki_bro/views/store/widgets/category_tab.dart';
import '../../core/widgets/appbar/appbar.dart';
import '../../core/widgets/appbar/tabbar.dart';
import '../../core/widgets/brands/t_brand_card.dart';
import '../../core/widgets/custom_shapes/containers/search_container.dart';
import '../../core/widgets/layouts/grid_layout.dart';
import '../../core/widgets/products/cart/cart_menu_icon.dart';
import '../../core/widgets/texts/section_heading.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/sizes.dart';
import '../../core/helpers/helper_functions.dart';
import '../brand/all_brands.dart';
import '../home/ui/search_view.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        backgroundColor: dark ? TColors.dark : TColors.light,
        body: NestedScrollView(
          /// Header
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      /// Appbar
                      TAppBar(
                        title: Text(
                          'Store',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: dark ? TColors.white : TColors.primary,
                              ),
                        ),
                        actions: [
                          TCartCounterIcon(
                            onPressed: () {},
                          ),
                        ],
                      ),

                      /// Search bar
                      const SizedBox(height: TSizes.spaceBtwItems),
                      TSearchContainer(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchView(),
                            ),
                          );
                        },
                        enableTextField: false,
                        text: 'Search in Store',
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      /// Featured Brands
                      TSectionHeading(
                        title: 'Featured Brands',
                        textColor: dark ? TColors.white : TColors.primary,
                        showActionButton: true,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AllBrandsScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                      /// Brands Grid
                      TGridLayout(
                        itemCount: 4,
                        mainAxisExtent: 80,
                        itemBuilder: (_, index) {
                          return const TBrandCard(showBorder: false);
                        },
                      )
                    ],
                  ),
                ),

                /// Tabs
                bottom: const TTabBar(
                  tabs: [
                    Tab(child: Text('Shoes')),
                    Tab(child: Text('Jacket')),
                    Tab(child: Text('Jeans')),
                    Tab(child: Text('Clothes')),
                    Tab(child: Text('T-Shirt')),
                    Tab(child: Text('Belts')),
                    Tab(child: Text('Bags')),
                  ],
                ),
              ),
            ];
          },

          /// Body
          body: const TabBarView(
            children: [
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
            ],
          ),
        ),
      ),
    );
  }
}

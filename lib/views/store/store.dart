import 'package:flutter/material.dart';
import 'package:nine_aki_bro/views/store/widgets/category_tab.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/appbar/tabbar.dart';
import '../../common/widgets/brands/t_brand_card.dart';
import '../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../common/widgets/layouts/grid_layout.dart';
import '../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../common/widgets/texts/section_heading.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/sizes.dart';
import '../../core/helpers/helper_functions.dart';
import '../brand/all_brands.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        //backgroundColor: TColors.primary,
        /// Appbar
        appBar: TAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            TCartCounterIcon(
              onPressed: () {},
            ),
          ],
        ),
        body: NestedScrollView(
          /// Header
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: THelperFunction.isDarkMode(context)
                    ? TColors.black
                    : TColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      /// Search bar
                      const SizedBox(height: TSizes.spaceBtwItems),
                      const TSearchContainer(
                        text: 'Search in Store',
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      /// Featured Brands
                      TSectionHeading(
                        title: 'Featured Brands',
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
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_aki_bro/core/helpers/helper_functions.dart';
import 'package:nine_aki_bro/core/helpers/home_cubit/home_cubit.dart';
import 'package:nine_aki_bro/core/models/product_model.dart';
import 'package:nine_aki_bro/views/home/ui/widgets/home_appbar.dart';
import 'package:nine_aki_bro/views/home/ui/widgets/home_categories.dart';
import 'package:nine_aki_bro/views/home/ui/widgets/promo_slider.dart';

import '../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../common/widgets/layouts/grid_layout.dart';
import '../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../common/widgets/texts/section_heading.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/sizes.dart';
import '../../all_products/all_products.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.dark : TColors.light,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            const TPrimaryHeaderContainer(
              child: Column(
                children: [
                  SizedBox(height: TSizes.spaceBtwItems),

                  /// Appbar
                  THomeAppBar(),
                  SizedBox(height: TSizes.spaceBtwSections),

                  /// Searchbar
                  TSearchContainer(
                    text: 'Search in Store',
                    showBorder: false,
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),

                  /// Categories
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        /// Heading
                        TSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: TColors.white,
                        ),
                        SizedBox(height: TSizes.spaceBtwItems),

                        /// Categories
                        THomeCategories()
                      ],
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// Promo Slider
                  const TPromoSlider(
                    banners: [
                      "assets/images/bag.png",
                      "assets/images/t-shirt.png",
                      "assets/images/jeans.png",
                      "assets/images/belt.png",
                      'assets/images/jacket.png',
                      'assets/images/shoes.png',
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Heading
                  TSectionHeading(
                    title: 'Popular Product',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllProducts(),
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// Popular Products
                  BlocProvider(
                    create: (context) => HomeCubit()..getProducts(),
                    child: BlocConsumer<HomeCubit, HomeState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          List<ProductModel> products =
                              context.read<HomeCubit>().products;
                          return state is GetDataLoading
                              ? const Center(child: CircularProgressIndicator())
                              : TGridLayout(
                                  itemCount: products.length,
                                  itemBuilder: (_, index) =>
                                      TProductCardVertical(
                                    productModel: products[index],
                                  ),
                                );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_aki_bro/core/helpers/home_cubit/home_cubit.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../common/widgets/products/product_cards/product_card_horizontal.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../core/constants/sizes.dart';

class SubCategoriesScreen extends StatefulWidget {
  const SubCategoriesScreen({super.key, required this.categoryId});
  final String categoryId;

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<HomeCubit>().getProductsByCategory(widget.categoryId);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Shoes'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Banner
              const TRoundedImage(
                width: double.infinity,
                imageUrl: "assets/images/shoes.png",
                applyImageRadius: true,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Sub-Categories
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  final filteredProducts =
                      context.read<HomeCubit>().categoryProduct;
                  return state is GetDataLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            /// Heading
                            TSectionHeading(
                              title: 'Sport Shoes',
                              onPressed: () {},
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems / 2),

                            SizedBox(
                              height: 120,
                              child: ListView.separated(
                                itemCount: filteredProducts.length,
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: TSizes.spaceBtwItems),
                                itemBuilder: (context, index) =>
                                    TProductCardHorizontal(
                                  productModel: filteredProducts[index],
                                ),
                              ),
                            ),
                          ],
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

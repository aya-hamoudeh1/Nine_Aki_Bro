import 'package:flutter/material.dart';
import '../../core/widgets/appbar/appbar.dart';
import '../../core/widgets/brands/t_brand_card.dart';
import '../../core/widgets/layouts/grid_layout.dart';
import '../../core/widgets/texts/section_heading.dart';
import '../../core/constants/sizes.dart';
import 'brands_products.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Brand',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Heading
              const TSectionHeading(title: 'Brands'),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Brands
              TGridLayout(
                itemCount: 10,
                mainAxisExtent: 80,
                itemBuilder: (context, index) => TBrandCard(
                  showBorder: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BrandProducts(),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

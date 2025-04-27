import 'package:flutter/cupertino.dart';

import '../../../core/constants/colors.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../../core/widgets/brands/brand_show_case.dart';
import '../../../core/widgets/texts/section_heading.dart';
import '../../../core/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brands
              const TBrandShowCase(
                images: [
                  'assets/images/t-shirt.png',
                  'assets/images/shoes.png',
                  'assets/images/jeans.png',
                  'assets/images/jacket.png',
                ],
              ),
              const TBrandShowCase(
                images: [
                  'assets/images/t-shirt.png',
                  'assets/images/shoes.png',
                  'assets/images/jeans.png',
                  'assets/images/jacket.png',
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Products You May Like
              TSectionHeading(
                title: 'You might like',
                textColor: dark ? TColors.white : TColors.primary,
                showActionButton: true,
                onPressed: () {},
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              // TGridLayout(
              //   itemCount: 4,
              //   itemBuilder: (_, index) => const TProductCardVertical(),
              // ),
              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ],
    );
  }
}

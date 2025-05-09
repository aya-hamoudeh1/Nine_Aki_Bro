import 'package:flutter/material.dart';
import 'package:nine_aki_bro/views/checkout/widgets/billing_address_section.dart';
import 'package:nine_aki_bro/views/checkout/widgets/billing_amount_section.dart';
import 'package:nine_aki_bro/views/checkout/widgets/billing_payment_section.dart';
import '../../core/widgets/appbar/appbar.dart';
import '../../core/widgets/products/cart/coupon_widget.dart';
import '../../core/widgets/custom_shapes/containers/rounded_container.dart';
import '../../core/widgets/success_screen/success_screen.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/sizes.dart';
import '../../core/helpers/helper_functions.dart';
import '../cart/ui/widgets/cart_items.dart';
import '../nav_bar/ui/navigation_menu.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Order Review',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Items in Cart
              const TCartItems(showAddRemoveButton: false),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Coupon TextField
              const TCouponCode(),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Billing Section
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.black : TColors.white,
                child: const Column(
                  children: [
                    /// Pricing
                    TBillingAmountSection(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    /// Divider
                    Divider(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    /// Payment Method
                    TBillingPaymentSection(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    /// Address
                    TBillingAddressSection()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      /// Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SuccessScreen(
                  image: 'assets/images/animations/Animation1.json',
                  title: 'Payment Success',
                  subTitle: 'Your item will be shipped soon!',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NavigationMenu(),
                      ),
                    );
                  },
                ),
              ),
            );
          },
          child: const Text('Checkout \$256.0'),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../cart/logic/cubit/cart_cubit/cart_cubit.dart';
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
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading || state is CartInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    const TCartItems(showAddRemoveButton: false),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    const TCouponCode(),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    TRoundedContainer(
                      showBorder: true,
                      padding: const EdgeInsets.all(TSizes.md),
                      backgroundColor: dark ? TColors.black : TColors.white,
                      child: const Column(
                        children: [
                          TBillingAmountSection(),
                          SizedBox(height: TSizes.spaceBtwItems),
                          Divider(),
                          SizedBox(height: TSizes.spaceBtwItems),
                          TBillingPaymentSection(),
                          SizedBox(height: TSizes.spaceBtwItems),
                          TBillingAddressSection(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is CartCheckoutLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartCheckoutSuccess) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SuccessScreen(
                      image: 'assets/images/animations/Animation1.json',
                      title: 'Payment Success',
                      subTitle: 'Your item will be shipped soon!',
                      onPressed: () {
                        context.read<CartCubit>().loadCart();
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
            );
            return const SizedBox();
          } else if (state is CartCheckoutError) {
            return Center(
              child: Text('Error loading cart: ${state.message}'),
            );
          } else {
            return const Center(child: Text('Unexpected error loading cart.'));
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () async {
            context.read<CartCubit>().checkoutCart();
          },
          child: const Text('Checkout \$256.0'),
        ),
      ),
    );
  }
}

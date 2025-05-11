import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_aki_bro/views/cart/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:nine_aki_bro/views/cart/ui/widgets/cart_items.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/widgets/appbar/appbar.dart';
import '../../checkout/checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      if (state is CartInitial) {
        context.read<CartCubit>().loadCart();
      }
      return Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
          title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
        ),
        body: const Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),

          /// Items in Cart
          child: TCartItems(),
        ),

        /// Checkout Button
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CheckoutScreen(),
                ),
              );
            },
            child: const Text('Checkout \$256.0'),
          ),
        ),
      );
    });
  }
}

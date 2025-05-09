import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/sizes.dart';
import '../../../../core/helpers/home_cubit/home_cubit.dart';
import '../../../../core/widgets/products/cart/add_remove_button.dart';
import '../../../../core/widgets/products/cart/cart_item.dart';
import '../../../../core/widgets/texts/t_product_price_text.dart';


class TCartItems extends StatelessWidget {
  const TCartItems({super.key, this.showAddRemoveButton = true});

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    final cartItems = context.watch<HomeCubit>().cartItems;
    return ListView.separated(
      shrinkWrap: true,
      itemCount: cartItems.length,
      separatorBuilder: (_, __) =>
          const SizedBox(height: TSizes.spaceBtwSections),
      itemBuilder: (_, index) {
        final item = cartItems[index];
        return Column(
          children: [
            /// Cart Item
            TCartItem(product: item),
            if (showAddRemoveButton)
              const SizedBox(height: TSizes.spaceBtwItems),

            /// Add Remove Button Row with total Price
            if (showAddRemoveButton)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      /// Extra Space
                      const SizedBox(width: 70),

                      /// Add Remove Buttons
                      TProductQuantityWithAddRemoveButton(
                          quantity: item.quantity),
                    ],
                  ),

                  /// Product total price
                  TProductPriceText(price: item.price.toString()),
                ],
              ),
          ],
        );
      },
    );
  }
}

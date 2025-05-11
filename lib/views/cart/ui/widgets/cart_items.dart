import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nine_aki_bro/core/constants/colors.dart';
import 'package:nine_aki_bro/views/cart/logic/cubit/cart_cubit/cart_cubit.dart';

import '../../../../core/constants/sizes.dart';
import '../../../../core/widgets/products/cart/add_remove_button.dart';
import '../../../../core/widgets/products/cart/cart_item.dart';
import '../../../../core/widgets/texts/t_product_price_text.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({super.key, this.showAddRemoveButton = true});

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoading || state is CartInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CartLoaded) {
          final cartItems = state.items;

          if (cartItems.isEmpty) {
            return const Center(
              child: Text('Your cart is empty.'),
            );
          }
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
                  TCartItem(
                    product: item,
                    variant:
                        (item.variants != null && item.variants!.isNotEmpty)
                            ? item.variants!.first
                            : null,
                  ),
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
                              quantity: item.quantity,
                              onAdd: () {
                                context
                                    .read<CartCubit>()
                                    .incrementQuantity(item);
                              },
                              onRemove: () {
                                context
                                    .read<CartCubit>()
                                    .decrementQuantity(item);
                              },
                            ),
                          ],
                        ),

                        /// Product total price
                        TProductPriceText(price: item.price.toString()),
                      ],
                    ),

                  /// Remove from cart button
                  if (showAddRemoveButton)
                    TextButton.icon(
                      onPressed: () {
                        showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: TColors.primary,
                            title: const Text('Confirm Deletion'),
                            content: const Text(
                              'Are you sure you want to delete this item from your cart?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: const Text('Delete',
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        ).then((shouldDelete) {
                          if (shouldDelete == true) {
                            context.read<CartCubit>().deleteItemFromCart(item);
                          }
                        });
                      },
                      icon: const Icon(Iconsax.trash,
                          size: 16, color: Colors.red),
                      label: const Text(
                        "Delete item",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              );
            },
          );
        } else if (state is CartError) {
          return Center(
            child: Text('Error loading cart: ${state.message}'),
          );
        } else {
          return const Center(
            child: Text('Unexpected error loading cart.'),
          );
        }
      },
    );
  }
}

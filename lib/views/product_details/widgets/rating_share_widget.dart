import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nine_aki_bro/views/product_reviews/logic/cubit/product_rate_cubit.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/models/product_model.dart';

class TRatingAndShare extends StatelessWidget {
  const TRatingAndShare({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductRateCubit()..getRates(productId: productModel.productId!),
      child: BlocConsumer<ProductRateCubit, ProductRateState>(
          listener: (context, state) {},
          builder: (context, state) {
            ProductRateCubit cubit = context.read<ProductRateCubit>();
            return state is GetRateLoading
                ? const Center(child: CircularProgressIndicator())
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Rating
                      Row(
                        children: [
                          const Icon(
                            Iconsax.star5,
                            color: Colors.amber,
                            size: 24,
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems / 2),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '${cubit.averageRate}',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const TextSpan(text: '(199)'),
                              ],
                            ),
                          ),
                        ],
                      ),

                      /// Share Button
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.share,
                          size: TSizes.iconMd,
                        ),
                      ),
                    ],
                  );
          }),
    );
  }
}

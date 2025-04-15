import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_aki_bro/core/models/product_model.dart';
import 'package:nine_aki_bro/views/product_reviews/ui/widgets/rating_progress_indicator.dart';
import 'package:nine_aki_bro/views/product_reviews/ui/widgets/user_review_card.dart';
import '../../../../../common/widgets/products/rating/rating_indicator.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../../../core/constants/sizes.dart';
import '../logic/cubit/product_rate_cubit.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key, required this.productModel,});
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductRateCubit()..getRates(productId: productModel.productId!),
      child: BlocConsumer<ProductRateCubit, ProductRateState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              /// Appbar
              appBar: const TAppBar(
                title: Text('Reviews & Ratings'),
                showBackArrow: true,
              ),

              /// Body
              body: state is GetRateLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(TSizes.defaultSpace),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                                "Ratings and reviews are verified and are from people who use the same type of device that you use."),
                            const SizedBox(height: TSizes.spaceBtwItems),

                            /// Overall Product Ratings
                            const TOverallProductRating(),
                            const TRatingBarIndicator(rating: 3.5),
                            Text('12,611',
                                style: Theme.of(context).textTheme.bodySmall),
                            const SizedBox(height: TSizes.spaceBtwSections),

                            /// User Reviews List
                            const UserReviewCard(),
                            const UserReviewCard(),
                            const UserReviewCard(),
                            const UserReviewCard(),
                          ],
                        ),
                      ),
                    ),
            );
          }),
    );
  }
}

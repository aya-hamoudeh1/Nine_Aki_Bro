import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_aki_bro/core/helpers/helper_functions.dart';
import 'package:nine_aki_bro/core/models/product_model.dart';
import 'package:nine_aki_bro/views/auth/logic/cubit/authentication_cubit.dart';
import 'package:nine_aki_bro/views/product_reviews/ui/widgets/rating_progress_indicator.dart';
import 'package:nine_aki_bro/views/product_reviews/ui/widgets/user_review_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../common/widgets/products/rating/rating_indicator.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/sizes.dart';
import '../../product_details/logic/cubit/product_details_cubit.dart';

class ProductReviewsScreen extends StatefulWidget {
  const ProductReviewsScreen({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;

  @override
  State<ProductReviewsScreen> createState() => _ProductReviewsScreenState();
}

class _ProductReviewsScreenState extends State<ProductReviewsScreen> {
  final TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return BlocProvider(
      create: (context) => ProductDetailsCubit()
        ..getRates(productId: widget.productModel.productId!),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          ProductDetailsCubit cubit = context.read<ProductDetailsCubit>();
          return Scaffold(
            /// Appbar
            appBar: const TAppBar(
              title: Text('Reviews & Ratings'),
              showBackArrow: true,
            ),

            /// Body
            body: state is GetRateLoading || state is AddCommentLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.only(
                      left: TSizes.defaultSpace,
                      right: TSizes.defaultSpace,
                      bottom: 80,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                              "Ratings and reviews are verified and are from people who use the same type of device that you use."),
                          const SizedBox(height: TSizes.spaceBtwItems),

                          /// Overall Product Ratings
                          const TOverallProductRating(),
                          TRatingBarSelector(
                            initialRating: cubit.averageRate.toDouble(),
                            isReadOnly: true,
                            onRatingUpdate: (p0) {},
                          ),
                          Text('12,611',
                              style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(height: TSizes.spaceBtwSections),

                          /// User Reviews List
                          StreamBuilder(
                              stream: Supabase.instance.client
                                  .from('comments')
                                  .stream(primaryKey: ['comment_id'])
                                  .eq("for_product",
                                      widget.productModel.productId!)
                                  .order('created_at'),
                              builder: (_, snapshot) {
                                List<Map<String, dynamic>>? data =
                                    snapshot.data;
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasData) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: cubit.rates.length,
                                    itemBuilder: (context, index) {
                                      final commentData = data![index];
                                      return UserReviewCard(
                                        userName: commentData['user_name'] ??
                                            'Anonymous',
                                        comment: commentData['comment'] ?? '',
                                      );
                                    },
                                  );
                                } else if (!snapshot.hasData) {
                                  return const Center(
                                    child: Text('No Comments Yet!'),
                                  );
                                } else {
                                  return const Center(
                                    child: Text(
                                        'Something went error, please try again.'),
                                  );
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
            bottomSheet: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: dark ? TColors.dark : TColors.light,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: "Type Your Feedback",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () async {
                      // send review
                      await cubit.addComment(data: {
                        "comment": _commentController.text,
                        "for_user": cubit.userId,
                        "for_product": widget.productModel.productId,
                        "user_name": context
                                .read<AuthenticationCubit>()
                                .userDataModel
                                ?.name ??
                            "User Name"
                      });
                      _commentController.clear();
                    },
                    icon:
                        const Icon(Icons.send_rounded, color: TColors.primary),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}

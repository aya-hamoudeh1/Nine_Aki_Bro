import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';
import '../../logic/PromoSlider_cubit/promo_slider_cubit.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key,
    required this.banners,
  });

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PromoSliderCubit(),
      child: Column(
        children: [
          BlocBuilder<PromoSliderCubit, int>(builder: (context, currentIndex) {
            return CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  context.read<PromoSliderCubit>().changePage(index);
                },
              ),
              items:
                  banners.map((url) => TRoundedImage(imageUrl: url)).toList(),
            );
          }),
          const SizedBox(height: TSizes.spaceBtwItems),
          BlocBuilder<PromoSliderCubit, int>(
            builder: (context, currentIndex) {
              return Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    banners.length * 2 - 1,
                    (i) => i.isEven
                        ? TCircularContainer(
                            //margin: const EdgeInsets.only(right: 10),
                            width: 20,
                            height: 4,
                            backgroundColor: currentIndex == i ~/ 2
                                ? TColors.primary
                                : TColors.grey,
                          )
                        : const SizedBox(width: 5),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

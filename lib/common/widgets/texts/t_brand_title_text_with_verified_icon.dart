import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nine_aki_bro/common/widgets/texts/t_brand_title_text.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/enums.dart';
import '../../../core/constants/sizes.dart';

class TBrandTitleWithVerifiedIcon extends StatelessWidget {
  const TBrandTitleWithVerifiedIcon(
      {super.key,
      required this.title,
      this.maxLines = 1,
      this.textColor,
      this.iconColor = TColors.primary,
      this.textAlign = TextAlign.center,
      this.brandTextSizes = TextSizes.small});

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSizes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TBrandTitleText(
            title: title,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSize: brandTextSizes,
          ),
        ),
        const SizedBox(
          width: TSizes.xs,
        ),
        Icon(
          Iconsax.verify5,
          color: iconColor,
          size: TSizes.iconXs,
        ),
      ],
    );
  }
}

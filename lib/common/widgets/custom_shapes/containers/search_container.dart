import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/device/device_utility.dart';
import '../../../../core/helpers/helper_functions.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
    required this.enableTextField,
    this.controller,
    this.onChanged, this.query,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final bool enableTextField;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? query;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: TDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(TSizes.md),
          decoration: BoxDecoration(
            color: showBackground
                ? dark
                    ? TColors.dark
                    : TColors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            border: showBorder
                ? Border.all(
                    color: TColors.grey,
                  )
                : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: TColors.darkGrey,
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Expanded(
                child: enableTextField
                    ? TextField(
                        controller: controller,
                        onChanged: onChanged,
                        style: Theme.of(context).textTheme.bodySmall,
                        cursorColor: TColors.primary,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: text,
                        ),
                      )
                    : Text(
                        text,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

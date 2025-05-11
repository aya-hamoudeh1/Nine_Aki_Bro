import 'package:flutter/material.dart';
import 'package:nine_aki_bro/views/order/ui/widgets/order_list.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/widgets/appbar/appbar.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'My Order',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),

        /// Order
        child: TOrderListItems(),
      ),
    );
  }
}

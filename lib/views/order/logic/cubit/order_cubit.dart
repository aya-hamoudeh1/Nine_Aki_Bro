import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/api/api_services.dart';
import '../../../../core/models/product_model.dart';
part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());
  final ApiServices _apiServices = ApiServices();
  final String userId = Supabase.instance.client.auth.currentUser!.id;

  /// Get User Order
  Future<void> getUserOrders() async {
    emit(OrderLoading());
    try {
      final response =
          await _apiServices.getData('products?select=*,purchase(*)');
      log(response.data);
      if (response.data == null || response.data.isEmpty) {
        emit(OrderLoaded(const []));
        return;
      }
      final orders = <ProductModel>[];
      for (var item in response.data) {
        final product = ProductModel.fromJson(item);
        final userPurchases = product.purchase
            ?.where((purchase) => purchase.forUser == userId)
            .toList();

        if (userPurchases != null && userPurchases.isNotEmpty) {
          final userPurchase = userPurchases.first;

          product.userOrderStatus = userPurchase.status;

          orders.add(product);
        }
      }
      emit(OrderLoaded(orders));
    } catch (e) {
      emit(OrderError('Failed to load orders'));
    }
  }
}

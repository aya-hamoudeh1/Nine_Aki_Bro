import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/api/api_services.dart';
import '../../../../../core/models/product_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  final ApiServices _apiServices = ApiServices();
  final String userId = Supabase.instance.client.auth.currentUser!.id;


  Future<void> loadCart() async {
    emit(CartLoading());
    try {
      final response = await _apiServices.getData(
        'cart?for_user=eq.$userId&select=*,products(*)',
      );

      final items = response.data.map<ProductModel>((item) {
        final product = ProductModel.fromJson(item['products']);
        product.quantity = item['quantity'];
        return product;
      }).toList();

      emit(CartLoaded(items));
    } catch (e) {
      emit(CartError("Failed to load the cart"));
    }
  }

  Future<void> addToCart(ProductModel product) async {
    final currentState = state;
    if (currentState is CartLoaded) {
      final existing = currentState.items.firstWhere(
            (p) => p.productId == product.productId,
        orElse: () => ProductModel(productId: '', quantity: 0),
      );

      if (existing.productId != '') {
        await _apiServices.patchData(
          'cart?for_user=eq.$userId&for_product=eq.${product.productId}',
          {'quantity': existing.quantity + 1},
        );
      } else {
        await _apiServices.postData('cart', {
          'for_user': userId,
          'for_product': product.productId,
          'quantity': 1,
        });
      }

      await loadCart();
    }
  }
}

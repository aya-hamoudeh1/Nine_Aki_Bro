import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nine_aki_bro/core/api/api_services.dart';
import 'package:nine_aki_bro/core/models/favorite_model.dart';
import 'package:nine_aki_bro/core/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/category_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final ApiServices _apiServices = ApiServices();
  final String userId = Supabase.instance.client.auth.currentUser!.id;

  List<ProductModel> products = [];
  List<ProductModel> searchResults = [];
  bool isSearching = false;
  List<ProductModel> categoryProduct = [];
  List<CategoryModel> categories = [];
  List<ProductModel> cartItems = [];

  /// Get All Product
  Future<void> getProducts() async {
    emit(GetDataLoading());
    try {
      products.clear();
      searchResults.clear();
      // categories.clear();
      // favoriteProductList.clear();
      var response = await _apiServices
          .getData('products?select=*,favorite(*),purchase(*)');
      for (var product in response.data) {
        products.add(ProductModel.fromJson(product));
      }
      getFavoriteProduct();
      await getCategories();
      emit(GetDataSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetDataError());
    }
  }

  /// Search
  void search(String? query) {
    searchResults.clear();
    if (query != null && query.isNotEmpty) {
      isSearching = true;
      for (var product in products) {
        if (product.productName!.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(product);
        }
      }
      emit(GetDataSuccess());
    } else {
      isSearching = false;
      searchResults.clear();
      emit(GetDataSuccess());
    }
  }

  /// Get Categories
  Future<void> getCategories() async {
    try {
      var response = await _apiServices.getData('category');
      categories = List<CategoryModel>.from(
          response.data.map((category) => CategoryModel.fromJson(category)));
      emit(GetDataSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetDataError());
    }
  }

  /// Get Product By Category
  void getProductsByCategory(String? categoryId) {
    categoryProduct.clear();
    if (categoryId != null) {
      for (var product in products) {
        log("Product ${product.productName} has categoryId: ${product.categoryId}");
        if (product.categoryId == categoryId) {
          categoryProduct.add(product);
        }
      }
    }
    log("Filtered Products: ${categoryProduct.length}");
  }

  void onCategorySelected(String categoryId) {
    getProductsByCategory(categoryId);
  }

  /// Add To Favorite
  Map<String, bool> favoriteProduct = {};
  Future<void> addToFavorite(String productId) async {
    emit(AddToFavoriteLoading());
    try {
      await _apiServices.postData('favorite', {
        'is_favorite': true,
        'for_user': userId,
        'for_product': productId,
      });
      favoriteProduct.addAll({productId: true});
      final product = products.firstWhere((p) => p.productId == productId);
      favoriteProductList.add(product);
      emit(AddToFavoriteSuccess());
    } catch (e) {
      log(e.toString());
      emit(AddToFavoriteError());
    }
  }

  bool checkIsFavorite(String productId) {
    return favoriteProduct.containsKey(productId);
  }

  /// Remove From Favorite
  Future<void> removeFromFavorite(String productId) async {
    emit(RemoveFavoriteLoading());
    try {
      await _apiServices
          .deleteData('favorite?for_user=eq.$userId&for_product=eq.$productId');
      favoriteProduct.removeWhere((key, value) => key == productId);
      favoriteProductList
          .removeWhere((product) => product.productId == productId);
      emit(RemoveFavoriteSuccess());
    } catch (e) {
      log(e.toString());
      emit(RemoveFavoriteError());
    }
  }

  /// Get Favorite Product
  List<ProductModel> favoriteProductList = [];
  void getFavoriteProduct() {
    for (ProductModel product in products) {
      if (product.favoriteProduct != null &&
          product.favoriteProduct!.isNotEmpty) {
        for (Favorite favorite in product.favoriteProduct!) {
          if (favorite.forUser == userId) {
            favoriteProductList.add(product);
            favoriteProduct.addAll({product.productId!: true});
          }
        }
      }
    }
  }

  /// Add To Cart
  Future<void> addToCart(ProductModel productModel) async {
    emit(AddToCartLoading());
    try {
      ProductModel? existingProduct;
      try {
        existingProduct = cartItems.firstWhere(
          (item) => item.productId == productModel.productId,
        );
      } catch (e) {
        existingProduct = null;
      }

      if (existingProduct != null) {
        await _apiServices.patchData(
            'cart?for_user=eq.$userId&for_product=eq.${productModel.productId}',
            {
              'quantity': existingProduct.quantity + 1,
            });
        existingProduct.quantity += 1;
      } else {
        await _apiServices.postData('cart', {
          'for_user': userId,
          'for_product': productModel.productId,
          'quantity': 1,
        });
      }
      await getCartItems();
      emit(AddToCartSuccess());
    } catch (e) {
      log(e.toString());
      emit(AddToCartError());
    }
  }

  /// Get Cart Items
  Future<void> getCartItems() async {
    try {
      emit(GetCartItemLoading());
      cartItems.clear();
      final response = await _apiServices
          .getData('cart?for_user=eq.$userId&select=*,products(*)');

      for (var item in response.data) {
        final productJson = item['products'];
        final quantity = item['quantity'];
        final product = ProductModel.fromJson(productJson);
        product.quantity = quantity;
        bool alreadyExists =
            cartItems.any((p) => p.productId == product.productId);
        if (!alreadyExists) {
          cartItems.add(product);
        }
      }

      emit(GetCartItemSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetCartItemError());
    }
  }

  /// Buy Product
  Future<void> buyProduct({required String productId}) async {
    emit(BuyProductLoading());
    try {
      await _apiServices.postData('purchase', {
        "for_user": userId,
        "is_bought": true,
        "for_product": productId,
      });
      emit(BuyProductSuccess());
    } catch (e) {
      log(e.toString());
      emit(BuyProductError());
    }
  }
}

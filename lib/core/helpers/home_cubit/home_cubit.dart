import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nine_aki_bro/core/api/api_services.dart';
import 'package:nine_aki_bro/core/models/product_model.dart';
import '../../models/category_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final ApiServices _apiServices = ApiServices();

  List<ProductModel> products = [];
  List<ProductModel> searchResults = [];
  bool isSearching = false;
  List<ProductModel> categoryProduct = [];
  List<CategoryModel> categories = [];

  /// Get All Product
  Future<void> getProducts() async {
    emit(GetDataLoading());
    try {
      products.clear();
      searchResults.clear();
      var response = await _apiServices
          .getData('products?select=*,favorite(*),purchase(*)');
      for (var product in response.data) {
        products.add(ProductModel.fromJson(product));
      }
      await getCategories();
      emit(GetDataSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetDataError());
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
}

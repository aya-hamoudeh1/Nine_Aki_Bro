import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nine_aki_bro/core/api/api_services.dart';
import 'package:nine_aki_bro/core/models/product_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final ApiServices _apiServices = ApiServices();

  List<ProductModel> products = [];

  Future<void> getProducts() async {
    emit(GetDataLoading());
    try {
      var response = await _apiServices
          .getData('products?select=*,favorite(*),purchase(*)');
      for (var product in response.data) {
        products.add(ProductModel.fromJson(product));
      }
      emit(GetDataSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetDataError());
    }
  }
}

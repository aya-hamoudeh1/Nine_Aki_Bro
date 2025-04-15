import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:nine_aki_bro/core/api/api_services.dart';

import '../models/rate_model.dart';

part 'product_rate_state.dart';

class ProductRateCubit extends Cubit<ProductRateState> {
  ProductRateCubit() : super(ProductRateInitial());

  final ApiServices _apiServices = ApiServices();

  List<RatingModel> rates = [];
  int averageRate = 0;

  Future<void> getRates({required String productId}) async {
    emit(GetRateLoading());
    try {
      Response response = await _apiServices
          .getData('rates?select=*&for_product=eq.$productId');
      for (var rate in response.data) {
        rates.add(RatingModel.fromJson(rate));
      }
      _getAverageMethod();
      log(averageRate.toString());
      emit(GetRateSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetRateError());
    }
  }

  void _getAverageMethod() {
    for (var userRate in rates) {
      log(userRate.rate.toString());
      if (userRate.rate != null) {
        averageRate += userRate.rate!;
      }
    }
    averageRate = averageRate ~/ rates.length;
  }
}

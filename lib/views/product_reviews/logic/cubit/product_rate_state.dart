part of 'product_rate_cubit.dart';

@immutable
sealed class ProductRateState {}

final class ProductRateInitial extends ProductRateState {}

final class GetRateLoading extends ProductRateState {}

final class GetRateSuccess extends ProductRateState {}

final class GetRateError extends ProductRateState {}

part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<ProductModel> items;

  CartLoaded(this.items);

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}

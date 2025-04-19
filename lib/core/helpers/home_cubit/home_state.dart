part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

/// Get Data
final class GetDataLoading extends HomeState {}

final class GetDataSuccess extends HomeState {}

final class GetDataError extends HomeState {}

/// Add To Favorite
final class AddToFavoriteLoading extends HomeState {}

final class AddToFavoriteSuccess extends HomeState {}

final class AddToFavoriteError extends HomeState {}

/// Remove From Favorite
final class RemoveFavoriteLoading extends HomeState {}

final class RemoveFavoriteSuccess extends HomeState {}

final class RemoveFavoriteError extends HomeState {}

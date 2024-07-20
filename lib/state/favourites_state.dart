import 'package:equatable/equatable.dart';
import 'package:shop_bag_app/data/model/product/product.dart';

class FavoritesState extends Equatable {
  final List<Product> favorites;

  final bool isLoadingFavourites;

  const FavoritesState({
    this.favorites = const [],
    this.isLoadingFavourites = false,
  });

  FavoritesState copyWith({
    List<Product>? favorites,
    bool? isLoadingFavourites,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      isLoadingFavourites: isLoadingFavourites ?? this.isLoadingFavourites,
    );
  }

  @override
  List<Object?> get props => [favorites, isLoadingFavourites];
}

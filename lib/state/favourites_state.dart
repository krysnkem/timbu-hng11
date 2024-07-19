import 'package:equatable/equatable.dart';
import 'package:shop_bag_app/data/model.dart/product.dart';

class FavoritesState extends Equatable {
  final List<Product> favorites;

  const FavoritesState({
    this.favorites = const [],
  });

  FavoritesState copyWith({
    List<Product>? favorites,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
    );
  }

  @override
  List<Object?> get props => [favorites];
}

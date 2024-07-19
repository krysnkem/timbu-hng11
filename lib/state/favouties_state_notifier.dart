import 'package:flutter/material.dart';
import 'package:shop_bag_app/data/model.dart/product.dart';
import 'package:shop_bag_app/state/favourites_state.dart';


class FavoritesStateNotifier extends ChangeNotifier {
  FavoritesState _favoritesState = const FavoritesState();

  FavoritesState get favoritesState => _favoritesState;

  void updateState(FavoritesState newState) {
    _favoritesState = newState;
    notifyListeners();
  }

  void addToFavorites(Product product) {
    final newFavorites = List<Product>.from(_favoritesState.favorites);
    if (!newFavorites.contains(product)) {
      newFavorites.add(product);
      _favoritesState = _favoritesState.copyWith(favorites: newFavorites);
      notifyListeners();
    }
  }

  void removeFromFavorites(Product product) {
    final newFavorites = List<Product>.from(_favoritesState.favorites);
    newFavorites.remove(product);
    _favoritesState = _favoritesState.copyWith(favorites: newFavorites);
    notifyListeners();
  }

  void clearFavorites() {
    _favoritesState = _favoritesState.copyWith(favorites: []);
    notifyListeners();
  }
}

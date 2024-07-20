import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shop_bag_app/data/db/favourites_db_client.dart';
import 'package:shop_bag_app/data/model/product/product.dart';
import 'package:shop_bag_app/state/favourites_state.dart';

class FavoritesStateNotifier extends ChangeNotifier {
  FavoritesStateNotifier() {
    loadAllFavourites();
  }
  FavoritesState _favoritesState = const FavoritesState();

  FavoritesState get favoritesState => _favoritesState;

  void updateState(FavoritesState newState) {
    _favoritesState = newState;
    notifyListeners();
  }

  void setLoading() {
    updateState(_favoritesState.copyWith(isLoadingFavourites: true));
  }

  void clearLoading() {
    updateState(_favoritesState.copyWith(isLoadingFavourites: false));
  }

  void loadAllFavourites() async {
    setLoading();
    final favourites = await FavouritesDbClient.getAllFavourites();
    _favoritesState = _favoritesState.copyWith(favorites: favourites);
    updateState(_favoritesState);
    clearLoading();
  }

  void addToFavorites(Product product) {
    final newFavorites = List<Product>.from(_favoritesState.favorites);
    if (!newFavorites.contains(product)) {
      newFavorites.add(product);
      _favoritesState = _favoritesState.copyWith(favorites: newFavorites);
      FavouritesDbClient.addToFavourite(product).then(
        (value) {
          _logDbFavourites();
        },
      );

      updateState(_favoritesState);
    }
  }

  void removeFromFavorites(Product product) {
    final newFavorites = List<Product>.from(_favoritesState.favorites);
    newFavorites.remove(product);
    _favoritesState = _favoritesState.copyWith(favorites: newFavorites);

    FavouritesDbClient.deleteFavourite(product.id).then(
      (value) {
        _logDbFavourites();
      },
    );
    updateState(_favoritesState);
  }

  void clearFavorites() {
    _favoritesState = _favoritesState.copyWith(favorites: []);
    FavouritesDbClient.deleteAll().then(
      (value) {
        _logDbFavourites();
      },
    );
    updateState(_favoritesState);
  }

  void _logDbFavourites() async {
    final itemsInDb = await FavouritesDbClient.getAllFavourites();
    log('###Favourites ITEMS IN DB ### $itemsInDb');
  }
}

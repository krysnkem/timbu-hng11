import 'package:flutter/material.dart';
import 'package:shop_bag_app/data/api/api_client.dart';
import 'package:shop_bag_app/data/api/result.dart';
import 'package:shop_bag_app/data/model.dart/cart_item.dart';
import 'package:shop_bag_app/data/model.dart/product.dart';
import 'package:shop_bag_app/state/app_state.dart';

class AppStateNotifier extends ChangeNotifier {
  AppState _appState = AppState(allProducts: []);

  AppState get appState => _appState;

  AppStateNotifier() {
    initializeData();
  }

  void updateState(AppState newState) {
    _appState = newState;
    notifyListeners();
  }

  // Implement other state modification methods similarly

  List<String> get getCategories =>
      _appState.allProducts.map((e) => e.category).toSet().toList();

  List<Product> getProductsForCategory(String category) {
    return _appState.allProducts
        .where((element) => element.category == category)
        .toList();
  }

  List<List<Product>> getProductsInPagesByCategory(String category) {
    final categoryList = getProductsForCategory(category);
    return splitProductsIntoSublists(categoryList, 2);
  }

  List<List<Product>> splitProductsIntoSublists(
      List<Product> products, int maxItemsPerList) {
    List<List<Product>> result = [];
    for (int i = 0; i < products.length; i += maxItemsPerList) {
      result.add(products.sublist(
          i,
          i + maxItemsPerList > products.length
              ? products.length
              : i + maxItemsPerList));
    }
    return result;
  }

  Map<String, List<List<Product>>> get getProductMapping {
    final allCategories = getCategories;
    final categoryMap = <String, List<List<Product>>>{};
    for (final category in allCategories) {
      categoryMap[category] = getProductsInPagesByCategory(category);
    }
    return categoryMap;
  }

  void addToCart(Product item) {
    final newData = List<CartItem>.from(_appState.cartItems);
    if (newData.any(
      (element) => element.product == item,
    )) {
      final index = newData.indexWhere(
        (element) => element.product == item,
      );
      newData[index].quantity = newData[index].quantity + 1;
    } else {
      newData.add(CartItem(product: item, quantity: 1));
    }

    _appState = _appState.copyWith(cartItems: newData);
    notifyListeners();
  }

  void removeFromCart(Product item) {
    final newData = List<CartItem>.from(_appState.cartItems);

    if (newData.any(
      (element) => element.product == item,
    )) {
      final index = newData.toList().indexWhere(
            (element) => element.product == item,
          );

      if (newData[index].quantity > 1) {
        --newData[index].quantity;
        _appState = _appState.copyWith(cartItems: newData);
      }
    } else {
      _appState = _appState.copyWith(
        cartItems: newData..remove(item),
      );
    }
    notifyListeners();
  }

  void deleteFromCart(Product item) {
    final newData = List<CartItem>.from(_appState.cartItems);
    final index = newData.toList().indexWhere(
          (element) => element.product == item,
        );
    newData.removeAt(index);
    _appState = _appState.copyWith(
      cartItems: newData,
    );

    notifyListeners();
  }

  void emptyCart() {
    final newData = List<CartItem>.from(_appState.cartItems);

    newData.clear();
    _appState = _appState.copyWith(
      cartItems: newData,
    );
    notifyListeners();
  }

  final apiClient = ApiClient();

  void initializeData() async {
    clearError();
    setIsLoading();
    final result = await apiClient.getListOfProducts();

    clearIsLoading();

    if (result is Success) {
      setProducts(List<Product>.from(result.data as List));
    } else {
      setError((result as Failure).message);
    }
    notifyListeners();
  }

  void setProducts(List<Product> products) {
    _appState = _appState.copyWith(allProducts: products);
    _appState = _appState.copyWith(productMapping: getProductMapping);
  }

  void setError(String error) {
    _appState = _appState.copyWith(error: error);
  }

  void clearError() {
    _appState = _appState.copyWith(error: null);
  }

  void setIsLoading() {
    _appState = _appState.copyWith(isLoading: true);
  }

  void clearIsLoading() {
    _appState = _appState.copyWith(isLoading: false);
    notifyListeners();
  }
}

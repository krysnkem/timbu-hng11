import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_bag_app/data/api/api_client.dart';
import 'package:shop_bag_app/data/api/result.dart';
import 'package:shop_bag_app/data/model.dart/cart_item.dart';
import 'package:shop_bag_app/data/model.dart/order_contact_details.dart';
import 'package:shop_bag_app/data/model.dart/payment_details.dart';
import 'package:shop_bag_app/data/model.dart/pre_order.dart';
import 'package:shop_bag_app/data/model.dart/product.dart';
import 'package:shop_bag_app/state/app_state.dart';

class AppStateNotifier extends ChangeNotifier {
  AppState _appState = const AppState(allProducts: []);

  AppStateNotifier() {
    initializeData();
  }

  AppState get appState => _appState;

  void updateState(AppState newState) {
    _appState = newState;
    notifyListeners();
  }

  void setPreOrder(PreOrder preOrder) {
    _appState = _appState.copyWith(preOrder: preOrder);
    notifyListeners();
  }

  void clearPreOrder() {
    _appState = _appState.copyWith(preOrder: null);
    notifyListeners();
  }

  void setContactDetails(OrderContactDetails contactDetails) {
    _appState = _appState.copyWith(contactDetails: contactDetails);
    notifyListeners();
  }

  void clearContactDetails() {
    _appState = _appState.copyWith(contactDetails: null);
    notifyListeners();
  }

  void clearPreOrderData() {
    updateState(_appState.copyWith(
      cartItems: List.from(_appState.cartItems)..clear(),
      shouldClear: true,
    ));
    notifyListeners();
  }

  void setPaymentDetails(PaymentDetails paymentDetails) {
    _appState = _appState.copyWith(paymentDetails: paymentDetails);
    notifyListeners();
  }

  void clearPaymentDetails() {
    _appState = _appState.copyWith(paymentDetails: null);
    notifyListeners();
  }

  void addToCart(Product item) {
    final newData = List<CartItem>.from(_appState.cartItems);
    if (newData.any(
      (element) => element.product == item,
    )) {
      final index = newData.indexWhere(
        (element) => element.product == item,
      );
      newData[index] =
          newData[index].copyWith(quantity: newData[index].quantity + 1);
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
        newData[index] =
            newData[index].copyWith(quantity: newData[index].quantity - 1);
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
    _appState = _appState.copyWith(
      allProducts: products,
      productMapping: getProductMapping(products),
    );
    notifyListeners();
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

  Map<String, List<List<Product>>> getProductMapping(List<Product> products) {
    final allCategories = products.map((e) => e.category).toSet().toList();
    final categoryMap = <String, List<List<Product>>>{};
    for (final category in allCategories) {
      final categoryList =
          products.where((element) => element.category == category).toList();
      final pages = splitProductsIntoSublists(categoryList, 2);
      categoryMap[category] = pages;
    }
    return categoryMap;
  }

  List<List<Product>> splitProductsIntoSublists(
      List<Product> products, int maxItemsPerList) {
    List<List<Product>> result = [];
    for (int i = 0; i < products.length; i += maxItemsPerList) {
      result.add(
        products.sublist(
          i,
          i + maxItemsPerList > products.length
              ? products.length
              : i + maxItemsPerList,
        ),
      );
    }
    return result;
  }
}

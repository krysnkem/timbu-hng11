import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_bag_app/data/api/api_client.dart';
import 'package:shop_bag_app/data/api/result.dart';
import 'package:shop_bag_app/data/db/cart_db_client.dart';
import 'package:shop_bag_app/data/model/cart_item/cart_item.dart';
import 'package:shop_bag_app/data/model/order_contact_details/order_contact_details.dart';
import 'package:shop_bag_app/data/model/payment_detail/payment_details.dart';
import 'package:shop_bag_app/data/model/pre_order/pre_order.dart';
import 'package:shop_bag_app/data/model/product/product.dart';
import 'package:shop_bag_app/state/app_state.dart';

class AppStateNotifier extends ChangeNotifier {
  AppState _appState = const AppState(allProducts: []);

  AppStateNotifier() {
    initializeAllData();
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
    CartItem cartItem;
    if (newData.any(
      (element) => element.product == item,
    )) {
      final index = newData.indexWhere(
        (element) => element.product == item,
      );

      cartItem = newData[index].copyWith(quantity: newData[index].quantity + 1);

      newData[index] = cartItem;
    } else {
      cartItem = CartItem(product: item, quantity: 1);
      newData.add(cartItem);
    }

    _appState = _appState.copyWith(cartItems: newData);
    CartDbClient.addToCart(cartItem).then(
      (value) {
        _logDbCart();
      },
    );
    notifyListeners();
  }

  void removeFromCart(Product item) {
    final newData = List<CartItem>.from(_appState.cartItems);
    CartItem cartItem;

    if (newData.any(
      (element) => element.product == item,
    )) {
      final index = newData.toList().indexWhere(
            (element) => element.product == item,
          );

      if (newData[index].quantity > 1) {
        cartItem =
            newData[index].copyWith(quantity: newData[index].quantity - 1);
        newData[index] = cartItem;

        _appState = _appState.copyWith(cartItems: newData);

        CartDbClient.addToCart(cartItem).then(
          (value) {
            _logDbCart();
          },
        );
      }
    } else {
      _appState = _appState.copyWith(
        cartItems: newData..remove(item),
      );
      CartDbClient.deleteFromCart(item.id).then(
        (value) {
          _logDbCart();
        },
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

    CartDbClient.deleteFromCart(item.id).then(
      (value) {
        _logDbCart();
      },
    );
    notifyListeners();
  }

  Future<void> emptyCart() async {
    final newData = List<CartItem>.from(_appState.cartItems);

    newData.clear();
    _appState = _appState.copyWith(
      cartItems: newData,
    );
    notifyListeners();

    await CartDbClient.deleteAllFromCart().then(
      (value) {
        _logDbCart();
      },
    );
  }

  void _logDbCart() async {
    final itemsInDb = await CartDbClient.getAllItems();
    log('### ITEMS IN DB ### $itemsInDb');
  }

  final apiClient = ApiClient();

  void initializeAllData() async {
    await Future.wait([
      loadCartItems(),
      loadProductsFromApi(),
    ]);
  }

  void initializeProducts() async {
    await loadProductsFromApi();
  }

  Future<void> loadCartItems() async {
    log('GETTING STORED CART');
    final items = await CartDbClient.getAllItems();
    log('STORED CART $items');

    if (items.isNotEmpty) {
      setCartItems(items);
    }
  }

  Future<void> loadProductsFromApi() async {
    clearError();
    setIsLoadingProducts();
    final result = await apiClient.getListOfProducts();

    clearIsLoadingProducts();

    if (result is Success) {
      setProducts(List<Product>.from(result.data as List));
    } else {
      setError((result as Failure).message);
    }
  }

  void setProducts(List<Product> products) {
    _appState = _appState.copyWith(
      allProducts: products,
      productMapping: getProductMapping(products),
    );
    notifyListeners();
  }

  void setCartItems(List<CartItem> cartItems) {
    _appState = _appState.copyWith(
      cartItems: cartItems,
    );
    notifyListeners();
  }

  void setError(String error) {
    _appState = _appState.copyWith(error: error);
    notifyListeners();
  }

  void clearError() {
    _appState = _appState.copyWith(error: null);
  }

  void setIsLoadingProducts() {
    _appState = _appState.copyWith(isLoadingAllProducts: true);
  }

  void clearIsLoadingProducts() {
    _appState = _appState.copyWith(isLoadingAllProducts: false);
    notifyListeners();
  }

  void setIsLoadingCart() {
    _appState = _appState.copyWith(isLoadingCartItems: true);
  }

  void clearIsLoadingCart() {
    _appState = _appState.copyWith(isLoadingCartItems: false);
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

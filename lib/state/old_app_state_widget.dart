import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shop_bag_app/data/api/api_client.dart';
import 'package:shop_bag_app/data/api/result.dart';
import 'package:shop_bag_app/data/model.dart/cart_item.dart';
import 'package:shop_bag_app/data/model.dart/product.dart';
import 'package:shop_bag_app/state/app_state.dart';
import 'package:shop_bag_app/state/app_state_scope.dart';

class OldAppStateWidget extends StatefulWidget {
  const OldAppStateWidget({super.key, required this.child});

  final Widget child;

  static OldAppStateWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<OldAppStateWidgetState>()!;
  }

  @override
  State<OldAppStateWidget> createState() => OldAppStateWidgetState();
}

class OldAppStateWidgetState extends State<OldAppStateWidget> {
  @override
  initState() {
    super.initState();
    initializeData();
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
    setState(() {});
  }

  AppState _appData = AppState(
    allProducts: [],
  );

  List<String> get getCategories => _appData.allProducts
      .map(
        (e) => e.category,
      )
      .toSet()
      .toList();

  List<Product> getProductsforCategory(String category) {
    return _appData.allProducts
        .where(
          (element) => element.category == category,
        )
        .toList();
  }

  List<List<Product>> getProductsInPagesByCategory(String category) {
    final categoryList = getProductsforCategory(category);
    return splitProductsIntoSublists(categoryList, 2);
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
                : i + maxItemsPerList),
      );
    }
    return result;
  }

  Map<String, List<List<Product>>> get getProductMapping {
    final allCategories = getCategories;
    final holder = <String, List<List<Product>>>{};
    for (final category in allCategories) {
      holder[category] = getProductsInPagesByCategory(category);
    }
    return holder;
  }

  void setProducts(List<Product> products) {
    _appData = _appData.copyWith(allProducts: products);
    _appData = _appData.copyWith(productMapping: getProductMapping);
    log('$getProductMapping');
  }

  void setError(String error) {
    _appData = _appData.copyWith(error: error);
  }

  void clearError() {
    _appData = _appData.copyWith(error: null);
  }

  void setIsLoading() => setState(() {
        _appData = _appData.copyWith(isLoading: true);
      });
  void clearIsLoading() {
    _appData = _appData.copyWith(isLoading: false);
    setState(() {});
  }

  void addToCart(Product item) {
    final newData = List<CartItem>.from(_appData.cartItems);
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

    _appData = _appData.copyWith(cartItems: newData);
    setState(() {});
  }

  void removeFromCart(Product item) {
    final newData = List<CartItem>.from(_appData.cartItems);

    if (newData.any(
      (element) => element.product == item,
    )) {
      final index = newData.toList().indexWhere(
            (element) => element.product == item,
          );

      if (newData[index].quantity > 1) {
        --newData[index].quantity;
        _appData = _appData.copyWith(cartItems: newData);
      }
    } else {
      _appData = _appData.copyWith(
        cartItems: newData..remove(item),
      );
    }
    setState(() {});
  }

  void deleteFromCart(Product item) {
    final newData = List<CartItem>.from(_appData.cartItems);
    final index = newData.toList().indexWhere(
          (element) => element.product == item,
        );
    newData.removeAt(index);
    _appData = _appData.copyWith(
      cartItems: newData,
    );
    setState(() {});
  }

  void emptyCart() {
    final newData = List<CartItem>.from(_appData.cartItems);

    newData.clear();
    _appData = _appData.copyWith(
      cartItems: newData,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AppStateScope(
      data: _appData,
      child: widget.child,
    );
  }
}

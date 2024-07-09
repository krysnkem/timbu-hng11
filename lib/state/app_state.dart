import 'package:flutter/material.dart';
import 'package:shop_bag_app/data/api/api_client.dart';
import 'package:shop_bag_app/data/api/result.dart';
import 'package:shop_bag_app/data/model.dart/cart_item.dart';
import 'package:shop_bag_app/data/model.dart/product.dart';

class AppState {
  AppState(
      {required this.allProducts,
      this.cartItems = const [],
      this.isLoading = false,
      this.error});

  final List<Product> allProducts;

  final List<CartItem> cartItems;

  final bool isLoading;

  final String? error;

  AppState copyWith(
      {List<Product>? allProducts,
      List<CartItem>? cartItems,
      bool? isLoading,
      String? error}) {
    return AppState(
      allProducts: allProducts ?? this.allProducts,
      cartItems: cartItems ?? this.cartItems,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AppStateScope extends InheritedWidget {
  const AppStateScope({
    super.key,
    required this.data,
    required super.child,
  });

  final AppState data;

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppStateScope>()!.data;
  }

  static AppState read(BuildContext context) {
    return context.findAncestorWidgetOfExactType<AppStateScope>()!.data;
  }

  @override
  bool updateShouldNotify(covariant AppStateScope oldWidget) {
    return data.cartItems != oldWidget.data.cartItems ||
        data.isLoading != oldWidget.data.isLoading ||
        data.error != oldWidget.data.error ||
        data.allProducts != oldWidget.data.allProducts;
  }
}

class AppStateWidget extends StatefulWidget {
  const AppStateWidget({super.key, required this.child});

  final Widget child;

  static AppStateWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<AppStateWidgetState>()!;
  }

  @override
  State<AppStateWidget> createState() => AppStateWidgetState();
}

class AppStateWidgetState extends State<AppStateWidget> {
  @override
  initState() {
    super.initState();
    initializeData();
  }

  final apiClient = ApiClient();

  void initializeData() async {
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

  void setProducts(List<Product> products) {
    _appData = _appData.copyWith(allProducts: products);
  }

  void setError(String error) {
    _appData = _appData.copyWith(error: error);
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

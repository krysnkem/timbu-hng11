import 'package:flutter/material.dart';
import 'package:shop_bag_app/data/data_source.dart';
import 'package:shop_bag_app/data/model.dart/cart_item.dart';
import 'package:shop_bag_app/data/model.dart/product.dart';

class AppState {
  AppState({required this.allProducts, this.cartItems = const {}});

  final List<Product> allProducts;

  final Set<CartItem> cartItems;

  AppState copyWith({
    List<Product>? allProducts,
    Set<CartItem>? cartItems,
  }) {
    return AppState(
      allProducts: allProducts ?? this.allProducts,
      cartItems: cartItems ?? this.cartItems,
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

  @override
  bool updateShouldNotify(covariant AppStateScope oldWidget) {
    if (data.cartItems.length != oldWidget.data.cartItems.length) {
      return true;
    }

    for (final item in data.cartItems.indexed) {
      if (!item.$2.isEqual(oldWidget.data.cartItems.toList()[item.$1])) {
        true;
      }
    }

    return false;
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
  AppState _appData = AppState(
    allProducts: DataSource.getProducts,
  );

  void addToCart(CartItem item) {
    final newData = Set<CartItem>.from(_appData.cartItems);
    final index = newData.toList().indexWhere(
          (element) => element.product.isEqual(item.product),
        );
    ++newData.toList()[index].quantity;
    _appData = _appData.copyWith(cartItems: newData);
    setState(() {});
  }

  void removeFromCart(CartItem item) {
    final newData = Set<CartItem>.from(_appData.cartItems);

    if (_appData.cartItems.contains(item)) {
      final index = newData.toList().indexWhere(
            (element) => element.product.isEqual(item.product),
          );
      --newData.toList()[index].quantity;
      _appData = _appData.copyWith(cartItems: newData);
    } else {
      _appData = _appData.copyWith(
        cartItems: newData..remove(item),
      );
    }
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

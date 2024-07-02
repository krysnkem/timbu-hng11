import 'package:flutter/material.dart';
import 'package:shop_bag_app/data/data_source.dart';
import 'package:shop_bag_app/data/model.dart/cart_item.dart';
import 'package:shop_bag_app/data/model.dart/product.dart';

class AppState {
  AppState({required this.allProducts, this.cartItems = const []});

  final List<Product> allProducts;

  final List<CartItem> cartItems;

  AppState copyWith({
    List<Product>? allProducts,
    List<CartItem>? cartItems,
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

  static AppState read(BuildContext context) {
    return context.findAncestorWidgetOfExactType<AppStateScope>()!.data;
  }

  @override
  bool updateShouldNotify(covariant AppStateScope oldWidget) {
    return data.cartItems != oldWidget.data.cartItems;
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
      } else {
        deleteFromCart(item);
      }
    } else {
      _appData = _appData.copyWith(
        cartItems: newData..remove(item),
      );
    }
    setState(() {});
  }

  void deleteFromCart(Product item) {
    print('Called');
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

  @override
  Widget build(BuildContext context) {
    return AppStateScope(
      data: _appData,
      child: widget.child,
    );
  }
}

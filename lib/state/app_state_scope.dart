import 'package:flutter/material.dart';
import 'package:shop_bag_app/state/app_state.dart';

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

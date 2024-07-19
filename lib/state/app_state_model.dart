import 'package:flutter/material.dart';
import 'package:shop_bag_app/data/model.dart/cart_item.dart';
import 'package:shop_bag_app/data/model.dart/product.dart';
import 'package:shop_bag_app/state/app_state_notifier.dart';

class AppStateModel extends InheritedModel<String> {
  const AppStateModel({
    Key? key,
    required this.notifier,
    required Widget child,
  }) : super(key: key, child: child);

  final AppStateNotifier notifier;

  @override
  bool updateShouldNotify(AppStateModel oldWidget) {
    return notifier != oldWidget.notifier;
  }

  @override
  bool updateShouldNotifyDependent(
      AppStateModel oldWidget, Set<String> dependencies) {
    final oldState = oldWidget.notifier.appState;
    final newState = notifier.appState;

    // Notify if any dependency changes
    if (dependencies.contains('cartItems') &&
        oldState.cartItems != newState.cartItems) {
      return true;
    }
    if (dependencies.contains('isLoading') &&
        oldState.isLoading != newState.isLoading) {
      return true;
    }
    if (dependencies.contains('allProducts') &&
        oldState.allProducts != newState.allProducts) {
      return true;
    }
    if (dependencies.contains('error') && oldState.error != newState.error) {
      return true;
    }
    if (dependencies.contains('productMapping') &&
        oldState.productMapping != newState.productMapping) {
      return true;
    }
    return false;
  }

  // Static method to get the AppStateNotifier instance
  static AppStateNotifier of(BuildContext context, {String? aspect}) {
    return InheritedModel.inheritFrom<AppStateModel>(context, aspect: aspect)!
        .notifier;
  }

  // Static methods to access specific state aspects
  static List<CartItem> ofCartItems(BuildContext context) {
    return InheritedModel.inheritFrom<AppStateModel>(context,
            aspect: 'cartItems')!
        .notifier
        .appState
        .cartItems;
  }

  static bool ofIsLoading(BuildContext context) {
    return InheritedModel.inheritFrom<AppStateModel>(context,
            aspect: 'isLoading')!
        .notifier
        .appState
        .isLoading;
  }

  static List<Product> ofAllProducts(BuildContext context) {
    return InheritedModel.inheritFrom<AppStateModel>(context,
            aspect: 'allProducts')!
        .notifier
        .appState
        .allProducts;
  }

  static String? ofError(BuildContext context) {
    return InheritedModel.inheritFrom<AppStateModel>(context, aspect: 'error')!
        .notifier
        .appState
        .error;
  }

  static Map<String, List<List<Product>>> ofProductMapping(
      BuildContext context) {
    return InheritedModel.inheritFrom<AppStateModel>(context,
            aspect: 'productMapping')!
        .notifier
        .appState
        .productMapping;
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_bag_app/data/model.dart/cart_item.dart';
import 'package:shop_bag_app/data/model.dart/order_item.dart';
import 'package:shop_bag_app/data/model.dart/pre_order.dart';
import 'package:shop_bag_app/data/model.dart/product.dart';
import 'package:shop_bag_app/state/app_state_notifier.dart';
import 'package:shop_bag_app/state/favouties_state_notifier.dart';
import 'package:shop_bag_app/state/order_state_notifier.dart';
import 'package:shop_bag_app/utils/validator.dart';

extension ContextExt on BuildContext {
  List<CartItem> get cartItems => select<AppStateNotifier, List<CartItem>>(
        (value) => value.appState.cartItems,
      );
  bool get isLoading => select<AppStateNotifier, bool>(
        (value) => value.appState.isLoading,
      );
  List<Product> get allProducts => select<AppStateNotifier, List<Product>>(
        (value) => value.appState.allProducts,
      );
  String? get error => select<AppStateNotifier, String?>(
        (value) => value.appState.error,
      );
  Map<String, List<List<Product>>> get productsToCategoryMapping =>
      select<AppStateNotifier, Map<String, List<List<Product>>>>(
        (value) => value.appState.productMapping,
      );
  PreOrder? get preOrder => select<AppStateNotifier, PreOrder?>(
        (value) => value.appState.preOrder,
      );

  bool get orderProcessing => select<OrderStateNotifier, bool>(
        (value) => value.orderState.creatingOrder,
      );
  bool get loadingOrders => select<OrderStateNotifier, bool>(
        (value) => value.orderState.gettingOrders,
      );

  List<OrderItem> get allOrders => select<OrderStateNotifier, List<OrderItem>>(
        (value) => value.orderState.allOrders,
      );
  List<Product> get allFavourites =>
      select<FavoritesStateNotifier, List<Product>>(
        (value) => value.favoritesState.favorites,
      );
}

extension StringExt on String {
  String get cleanText {
    String decoded = utf8.decode(runes.toList());
    // Normalize the string to remove any non-standard characters
    String normalized = decoded.replaceAll(RegExp(r'[\uFFFD]'), '');
    return normalized;
  }

  String get capitalize {
    if (isEmpty) return this; // Return empty string if input is empty

    List<String> words = split(' ');
    List<String> capitalizedWords = words.map((word) {
      if (word.isEmpty) return word; // Return empty word if input word is empty
      return word.substring(0, 1).toUpperCase() + word.substring(1);
    }).toList();

    return capitalizedWords.join(' ');
  }

  String get formattedAmount {
    return replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  bool get isValidPhoneNumber => isValidNigerianPhoneNumber(this);

  bool get isValidExpiryDateFormat => validateExpiryDate(this);
  bool get isValidMonth => validateMonth(this);
  bool get isValidYear => verifyExpiryYear(this);
}




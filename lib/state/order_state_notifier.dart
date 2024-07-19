import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_bag_app/data/model.dart/cart_item.dart';
import 'package:shop_bag_app/data/model.dart/order_contact_details.dart';
import 'package:shop_bag_app/data/model.dart/order_item.dart';
import 'package:shop_bag_app/data/model.dart/payment_details.dart';
import 'package:shop_bag_app/data/model.dart/pre_order.dart';

import 'order_state.dart';

class OrderStateNotifier extends ChangeNotifier {
  OrderState _orderState = const OrderState();

  OrderState get orderState => _orderState;

  void setCreatingOrder() {
    updateState(_orderState.copyWith(creatingOrder: true));
  }

  void clearCreatingOrder() {
    updateState(_orderState.copyWith(creatingOrder: false));
  }

  void setGettingOrders() {
    updateState(_orderState.copyWith(gettingOrders: true));
  }

  void clearGettingOrders() {
    updateState(_orderState.copyWith(gettingOrders: false));
  }

  void updateState(OrderState newState) {
    _orderState = newState;
    notifyListeners();
  }

  void setAllOrders(List<OrderItem> orders) {
    _orderState = _orderState.copyWith(allOrders: orders);
    notifyListeners();
  }

  void addOrder(OrderItem order) {
    final newOrders = List<OrderItem>.from(_orderState.allOrders);
    newOrders.add(order);
    _orderState = _orderState.copyWith(allOrders: newOrders);
    notifyListeners();
  }

  void removeOrder(String orderId) {
    final newOrders =
        _orderState.allOrders.where((order) => order.id != orderId).toList();
    _orderState = _orderState.copyWith(allOrders: newOrders);
    notifyListeners();
  }

  void clearOrders() {
    _orderState = _orderState.copyWith(allOrders: []);
    notifyListeners();
  }

  Future<bool> generateOrder({
    required PreOrder preOrder,
    required List<CartItem> cartItems,
    required OrderContactDetails contactDetails,
    required PaymentDetails paymentDetails,
  }) async {
    setCreatingOrder();
    await Future.delayed(const Duration(seconds: 5));
    final date = DateTime.now();
    final order = OrderItem(
      id: date.toIso8601String(), // Generate a unique ID
      orderRef: generateOrderRefFromDate(date),
      date: date,
      subTotal: preOrder.subTotal,
      deliveryFee: preOrder.deliveryFee,
      discountAmount: preOrder.discountAmount.toInt(),
      totalAmount: preOrder.totalAmount.toInt(),
      discountCode: preOrder.discountCode,
      items: List.from(cartItems),
      contactDetails: contactDetails,
      discountPercent: preOrder.discountPercent,
      paymentDetails: paymentDetails,
    );

    addOrder(order);

    clearCreatingOrder();
    return true;
  }

  String generateOrderRefFromDate(DateTime date) {
    final now = date;
    final timestamp = now.millisecondsSinceEpoch;
    final random = Random();
    final randomSuffix = random
        .nextInt(10000)
        .toString()
        .padLeft(4, '0'); // Generates a 4-digit random number

    return 'ORD-$timestamp-$randomSuffix';
  }
}

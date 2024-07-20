import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_bag_app/data/db/orders_db_client.dart';
import 'package:shop_bag_app/data/model/cart_item/cart_item.dart';
import 'package:shop_bag_app/data/model/order_contact_details/order_contact_details.dart';
import 'package:shop_bag_app/data/model/order_item/order_item.dart';
import 'package:shop_bag_app/data/model/payment_detail/payment_details.dart';
import 'package:shop_bag_app/data/model/pre_order/pre_order.dart';

import 'order_state.dart';

class OrderStateNotifier extends ChangeNotifier {
  OrderStateNotifier() {
    loadAllOrders();
  }
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

  void loadAllOrders() async {
    setGettingOrders();
    final orders = await OrdersDbClient.getAllOrders();
    if (orders.isNotEmpty) {
      setAllOrders(orders);
    }
    clearGettingOrders();
  }

  void setAllOrders(List<OrderItem> orders) {
    _orderState = _orderState.copyWith(allOrders: orders);
    notifyListeners();
  }

  void addOrder(OrderItem order) {
    final newOrders = List<OrderItem>.from(_orderState.allOrders);
    newOrders.add(order);
    _orderState = _orderState.copyWith(allOrders: newOrders);
    OrdersDbClient.addOrder(order).then(
      (value) {
        _logDbOrders();
      },
    );

    notifyListeners();
  }

  void removeOrder(String orderId) {
    final newOrders =
        _orderState.allOrders.where((order) => order.id != orderId).toList();
    _orderState = _orderState.copyWith(allOrders: newOrders);
    OrdersDbClient.deleteOrder(orderId).then(
      (value) {
        _logDbOrders();
      },
    );

    notifyListeners();
  }

  void clearOrders() {
    _orderState = _orderState.copyWith(allOrders: []);
    OrdersDbClient.deleteAll().then(
      (value) {
        _logDbOrders();
      },
    );

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

  void _logDbOrders() async {
    final itemsInDb = await OrdersDbClient.getAllOrders();
    dev.log('###Order ITEMS IN DB ### $itemsInDb');
  }
}

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:shop_bag_app/data/model/payment_detail/payment_details.dart';

import '../cart_item/cart_item.dart';
import '../order_contact_details/order_contact_details.dart';

part 'order_item.g.dart';

@HiveType(typeId: 8)
class OrderItem extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String orderRef;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final int subTotal;
  @HiveField(4)
  final int deliveryFee;
  @HiveField(5)
  final int discountAmount;
  @HiveField(6)
  final int discountPercent;
  @HiveField(7)
  final int totalAmount;
  @HiveField(8)
  final String discountCode;
  @HiveField(9)
  final List<CartItem> items;
  @HiveField(10)
  final OrderContactDetails contactDetails;
  @HiveField(11)
  final PaymentDetails paymentDetails;

  const OrderItem({
    required this.id,
    required this.orderRef,
    required this.date,
    required this.subTotal,
    required this.deliveryFee,
    required this.discountAmount,
    required this.discountPercent,
    required this.totalAmount,
    required this.discountCode,
    required this.items,
    required this.contactDetails,
    required this.paymentDetails,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderRef': orderRef,
      'date': date.toIso8601String(),
      'subTotal': subTotal,
      'deliveryFee': deliveryFee,
      'discountAmount': discountAmount,
      'discountPercent': discountPercent,
      'totalAmount': totalAmount,
      'discountCode': discountCode,
      'items': items.map((item) => item.toJson()).toList(),
      'contactDetails': contactDetails.toJson(),
      'paymentDetails': paymentDetails.toJson(),
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      orderRef: json['orderRef'],
      date: DateTime.parse(json['date']),
      subTotal: json['subTotal'],
      deliveryFee: json['deliveryFee'],
      discountAmount: json['discountAmount'],
      discountPercent: json['discountPercent'],
      totalAmount: json['totalAmount'],
      discountCode: json['discountCode'],
      items: (json['items'] as List<dynamic>)
          .map((item) => CartItem.fromJson(item))
          .toList(),
      contactDetails: OrderContactDetails.fromJson(json['contactDetails']),
      paymentDetails: PaymentDetails.fromJson(json['paymentDetails']),
    );
  }

  OrderItem copyWith({
    String? id,
    String? orderRef,
    DateTime? date,
    int? subTotal,
    int? deliveryFee,
    int? discountAmount,
    int? discountPercent,
    int? totalAmount,
    String? discountCode,
    List<CartItem>? items,
    OrderContactDetails? contactDetails,
    PaymentDetails? paymentDetails,
  }) {
    return OrderItem(
      id: id ?? this.id,
      orderRef: orderRef ?? this.orderRef,
      date: date ?? this.date,
      subTotal: subTotal ?? this.subTotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      discountAmount: discountAmount ?? this.discountAmount,
      discountPercent: discountPercent ?? this.discountPercent,
      totalAmount: totalAmount ?? this.totalAmount,
      discountCode: discountCode ?? this.discountCode,
      items: items ?? this.items,
      contactDetails: contactDetails ?? this.contactDetails,
      paymentDetails: paymentDetails ?? this.paymentDetails,
    );
  }

  @override
  List<Object?> get props => [
        id,
        orderRef,
        date,
        subTotal,
        deliveryFee,
        discountAmount,
        discountPercent,
        totalAmount,
        discountCode,
        items,
        contactDetails,
        paymentDetails,
      ];
}

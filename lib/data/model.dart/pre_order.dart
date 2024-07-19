import 'package:equatable/equatable.dart';
import 'cart_item.dart';

class PreOrder extends Equatable {
  final int subTotal;
  final int deliveryFee;
  final int discountAmount;
  final int discountPercent;
  final int totalAmount;
  final String discountCode;
  final List<CartItem> items;

  const PreOrder({
    required this.subTotal,
    required this.deliveryFee,
    required this.discountAmount,
    required this.discountPercent,
    required this.totalAmount,
    required this.discountCode,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'subTotal': subTotal,
      'deliveryFee': deliveryFee,
      'discountAmount': discountAmount,
      'discountPercent': discountPercent,
      'totalAmount': totalAmount,
      'discountCode': discountCode,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory PreOrder.fromJson(Map<String, dynamic> json) {
    return PreOrder(
      subTotal: json['subTotal'],
      deliveryFee: json['deliveryFee'],
      discountAmount: json['discountAmount'],
      discountPercent: json['discountPercent'],
      totalAmount: json['totalAmount'],
      discountCode: json['discountCode'],
      items: (json['items'] as List<dynamic>)
          .map((item) => CartItem.fromJson(item))
          .toList(),
    );
  }

  PreOrder copyWith({
    int? subTotal,
    int? deliveryFee,
    int? discountAmount,
    int? discountPercent,
    int? totalAmount,
    String? discountCode,
    List<CartItem>? items,
  }) {
    return PreOrder(
      subTotal: subTotal ?? this.subTotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      discountAmount: discountAmount ?? this.discountAmount,
      discountPercent: discountPercent ?? this.discountPercent,
      totalAmount: totalAmount ?? this.totalAmount,
      discountCode: discountCode ?? this.discountCode,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [
        subTotal,
        deliveryFee,
        discountAmount,
        discountPercent,
        totalAmount,
        discountCode,
        items,
      ];
}

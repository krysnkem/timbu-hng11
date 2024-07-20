import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../delivery_method/delivery_method.dart';

part 'order_contact_details.g.dart';

@HiveType(typeId: 7)
class OrderContactDetails extends Equatable {
  @HiveField(0)
  final DeliveryMethod deliveryMethod;
  @HiveField(1)
  final String? pickupLocation;
  @HiveField(2)
  final String? deliveryAddress;
  @HiveField(3)
  final String phone1;
  @HiveField(4)
  final String phone2;

  const OrderContactDetails({
    required this.deliveryMethod,
    this.pickupLocation,
    this.deliveryAddress,
    required this.phone1,
    required this.phone2,
  });

  Map<String, dynamic> toJson() {
    return {
      'deliveryMethod': deliveryMethod.toString(),
      'pickupLocation': pickupLocation,
      'deliveryAddress': deliveryAddress,
      'phone1': phone1,
      'phone2': phone2,
    };
  }

  factory OrderContactDetails.fromJson(Map<String, dynamic> json) {
    return OrderContactDetails(
      deliveryMethod: DeliveryMethod.values
          .firstWhere((e) => e.toString() == json['deliveryMethod']),
      pickupLocation: json['pickupLocation'],
      deliveryAddress: json['deliveryAddress'],
      phone1: json['phone1'],
      phone2: json['phone2'],
    );
  }

  OrderContactDetails copyWith({
    DeliveryMethod? deliveryMethod,
    String? pickupLocation,
    String? deliveryAddress,
    String? phone1,
    String? phone2,
  }) {
    return OrderContactDetails(
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      phone1: phone1 ?? this.phone1,
      phone2: phone2 ?? this.phone2,
    );
  }

  @override
  List<Object?> get props => [
        deliveryMethod,
        pickupLocation,
        deliveryAddress,
        phone1,
        phone2,
      ];
}

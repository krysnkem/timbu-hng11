import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:shop_bag_app/data/model/card_details/card_details.dart';

part 'payment_details.g.dart';

@HiveType(typeId: 5)
class PaymentDetails extends Equatable {
  @HiveField(0)
  final String type;
  @HiveField(1)
  final Object detail; // detail can be of any type, typically CardDetails

  const PaymentDetails({
    required this.type,
    required this.detail,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'detail': detail is CardDetails ? (detail as CardDetails).toJson() : null,
    };
  }

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      type: json['type'],
      detail: json['type'] == 'card' && json['detail'] != null
          ? CardDetails.fromJson(json['detail'])
          : '',
    );
  }

  @override
  List<Object?> get props => [
        type,
        detail,
      ];
}

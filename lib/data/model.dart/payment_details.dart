import 'package:equatable/equatable.dart';
import 'package:shop_bag_app/data/model.dart/card_details.dart';

class PaymentDetails extends Equatable {
  final String type;
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

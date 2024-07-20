import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'card_details.g.dart';

@HiveType(typeId: 4)
class CardDetails extends Equatable {
  @HiveField(0)
  final String cardHolderName;
  @HiveField(1)
  final String expiryDate;
  @HiveField(2)
  final String cardNumber;
  @HiveField(3)
  final String cvv;

  const CardDetails({
    required this.cardHolderName,
    required this.expiryDate,
    required this.cardNumber,
    required this.cvv,
  });

  Map<String, dynamic> toJson() {
    return {
      'card_holder_name': cardHolderName,
      'expiry_date': expiryDate,
      'card_number': cardNumber,
      'cvv': cvv,
    };
  }

  factory CardDetails.fromJson(Map<String, dynamic> json) {
    return CardDetails(
      cardHolderName: json['card_holder_name'],
      expiryDate: json['expiry_date'],
      cardNumber: json['card_number'],
      cvv: json['cvv'],
    );
  }

  @override
  List<Object?> get props => [
        cardHolderName,
        expiryDate,
        cardNumber,
        cvv,
      ];
}

import 'package:equatable/equatable.dart';

class CardDetails extends Equatable {
  final String cardHolderName;
  final String expiryDate;
  final String cardNumber;
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

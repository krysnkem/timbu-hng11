import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_bag_app/screens/payment_flow.dart';
import 'package:shop_bag_app/screens/widgets/height4.dart';
import 'package:shop_bag_app/screens/widgets/height8.dart';
import 'package:shop_bag_app/screens/widgets/primary_button.dart';
import 'package:shop_bag_app/utils/colors.dart';
import 'package:shop_bag_app/utils/formtters/card_input_formatter.dart';
import 'package:shop_bag_app/utils/formtters/cvv_formatter.dart';
import 'package:shop_bag_app/utils/formtters/expiry_date_formatter.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late final TextEditingController _cardNumber, _expiryDate, _cvv;

  final ValueNotifier<String> _cardNumberNotifer = ValueNotifier('');
  final ValueNotifier<String> _expiryDateNotifer = ValueNotifier('');

  @override
  void initState() {
    _cardNumber = TextEditingController()
      ..addListener(updateCardNumber)
      ..addListener(listenToAllFields);
    _expiryDate = TextEditingController()
      ..addListener(updateExiryDate)
      ..addListener(listenToAllFields);
    _cvv = TextEditingController()..addListener(listenToAllFields);
    super.initState();

  }

  void updateCardNumber() {
    _cardNumberNotifer.value = _cardNumber.text;
  }

  void updateExiryDate() {
    _expiryDateNotifer.value = _expiryDate.text;
  }

  @override
  void dispose() {
    _cardNumber.removeListener(listenToAllFields);
    _cardNumber.dispose();
    _expiryDate.removeListener(listenToAllFields);
    _expiryDate.dispose();
    _cvv.removeListener(listenToAllFields);
    _cvv.dispose();
    super.dispose();
  }

  final ValueNotifier<bool> _isComplete = ValueNotifier(false);

  bool get _cardNumberComplete => _cardNumber.text.length == 19;
  bool get _expiryDateComplete => _expiryDate.text.length == 5;
  bool get _cvvComplete => _cvv.text.length == 3;

  listenToAllFields() {
    _isComplete.value =
        _cardNumberComplete && _expiryDateComplete && _cvvComplete;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment',
          style: black19600,
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 24.0,
          right: 24.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/images/Card.png',
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                  Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ValueListenableBuilder<String>(
                              valueListenable: _cardNumberNotifer,
                              builder: (context, value, child) {
                                return Text(
                                  value.isEmpty ? '-------' : value,
                                  style: white20600Poppins,
                                );
                              }),
                          const Height8(),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Card holder name",
                                    style: white11400Poppins,
                                  ),
                                  ValueListenableBuilder<bool>(
                                    valueListenable: _isComplete,
                                    builder: (context, isComplete, child) {
                                      return Text(
                                        isComplete ? 'Hafsat Ardo' : '---',
                                        style: white11600Poppins,
                                      );
                                    },
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Expiry date",
                                    style: white11400Poppins,
                                  ),
                                  ValueListenableBuilder<String>(
                                    valueListenable: _expiryDateNotifer,
                                    builder: (context, value, child) {
                                      return Text(
                                        value.isEmpty ? '---' : value,
                                        style: white11600Poppins,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              ...List.generate(
                4,
                (_) => const Height8(),
              ),
              Text(
                'Card Number',
                style: black14500,
              ),
              const Height8(),
              const Height4(),
              TextField(
                controller: _cardNumber,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CardNumberInputFormatter(),
                ],
                decoration: InputDecoration(
                  hintText: '0000 0000 0000 0000',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: mainBlack.withOpacity(0.5),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ),
              ...List.generate(
                4,
                (_) => const Height8(),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expiry Date',
                          style: black14500,
                        ),
                        const Height8(),
                        const Height4(),
                        TextField(
                          controller: _expiryDate,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            ExpiryDateInputFormatter(),
                          ],
                          decoration: InputDecoration(
                            hintText: 'MM/YY',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: mainBlack.withOpacity(0.5),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CVV',
                          style: black14500,
                        ),
                        const Height8(),
                        const Height4(),
                        TextField(
                          controller: _cvv,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CVVNumberInputFormatter(),
                          ],
                          decoration: InputDecoration(
                            hintText: '123',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: mainBlack.withOpacity(0.5),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ...List.generate(
                4,
                (_) => const Height8(),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _isComplete,
                builder: (context, value, child) {
                  return PrimaryButton(
                    label: 'Make Payment',
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(
                        paymentSuccessful,
                      );
                    },
                    enabled: value,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

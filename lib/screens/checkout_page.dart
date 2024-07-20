import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_bag_app/data/model/delivery_method/delivery_method.dart';
import 'package:shop_bag_app/data/model/order_contact_details/order_contact_details.dart';
import 'package:shop_bag_app/screens/payment_flow.dart';
import 'package:shop_bag_app/screens/widgets/malltiverse_icon_widget.dart';
import 'package:shop_bag_app/screens/widgets/primary_button.dart';
import 'package:shop_bag_app/state/app_state_notifier.dart';
import 'package:shop_bag_app/utils/colors.dart';
import 'package:shop_bag_app/utils/extensions.dart';
import 'package:shop_bag_app/utils/formtters/phone_number_forammter.dart';
import 'package:shop_bag_app/utils/show_snackbar.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

import 'widgets/height8.dart';
import 'widgets/my_app_bar.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage>
    with SingleTickerProviderStateMixin {
  bool? _isPickupAddress1;

  DeliveryMethod? deliveryMethod;

  final pickUpAddress1 = 'Old Secretariat Complex, Area 1, Garki Abaji Abji';
  final pickUpAddress2 = 'Sokoto Street, Area 1, Garki Area 1 AMAC';

  late final TextEditingController _deliveryAddress;
  late final TextEditingController _phone1;
  late final TextEditingController _phone2;

  @override
  void initState() {
    super.initState();

    _deliveryAddress = TextEditingController();
    _phone1 = TextEditingController();
    _phone2 = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _deliveryAddress.dispose();
    _phone1.dispose();
    _phone2.dispose();
  }

  String? get pickUpAddress {
    if (_isPickupAddress1 != null) {
      return _isPickupAddress1! ? pickUpAddress1 : pickUpAddress2;
    }
    return null;
  }

  void clearPickUpAddress() {
    setState(() {
      _isPickupAddress1 = null;
    });
  }

  bool get isValid {
    if (deliveryMethod == null) {
      showWarningSnackBar(context, 'Select delivery method');
      return false;
    }
    if (deliveryMethod == DeliveryMethod.pickup) {
      if (_isPickupAddress1 == null) {
        showWarningSnackBar(context, 'Select a pickup address');

        return false;
      }
    }
    if (deliveryMethod == DeliveryMethod.delivery) {
      if (_deliveryAddress.text.isEmpty || _deliveryAddress.text.length < 10) {
        showWarningSnackBar(context, 'Enter full delivery address');

        return false;
      }
    }

    log('isInvalid: ${!_phone1.text.isValidPhoneNumber}');

    if (_phone1.text.isEmpty || !_phone1.text.isValidPhoneNumber) {
      showWarningSnackBar(context, 'Phone number 1 not valid');

      return false;
    }
    if (_phone2.text.isNotEmpty) {
      if (!_phone2.text.isValidPhoneNumber) {
        showWarningSnackBar(context, 'Phone number 2 not valid');

        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        title: Text(
          'Checkout',
          style: black19600,
        ),
        leading: const MalltiverseIconWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Builder(builder: (context) {
          if (context.preOrder == null) {
            return Center(
              child: Text(
                'No pending order',
                style: black24500,
              ),
            );
          }

          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Height8(),
                  const Height8(),
                  const Height8(),
                  Text(
                    'Select how to receive your package(s)',
                    style: black14500,
                  ),
                  const Height8(),
                  const Height8(),
                  RadioListTile(
                    value: DeliveryMethod.pickup,
                    groupValue: deliveryMethod,
                    activeColor: accentColor,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (value) {
                      if (value != null) {
                        deliveryMethod = value;
                        setState(() {});
                      }
                    },
                    title: Text(
                      'Pickup',
                      style: black14500,
                    ),
                  ),
                  AnimatedSize(
                    alignment: Alignment.bottomLeft,
                    duration: const Duration(
                        milliseconds: 300), // Duration of the animation
                    child: deliveryMethod == DeliveryMethod.pickup
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: RadioListTile(
                                  value: true,
                                  groupValue: _isPickupAddress1,
                                  activeColor: accentColor,
                                  contentPadding: EdgeInsets.zero,
                                  onChanged: (value) {
                                    if (value != null) {
                                      _isPickupAddress1 = value;
                                      setState(() {});
                                    }
                                  },
                                  title: Text(
                                    pickUpAddress1,
                                    style: black12400.copyWith(
                                        color: mainBlack.withOpacity(0.6)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: RadioListTile(
                                  value: false,
                                  activeColor: accentColor,
                                  groupValue: _isPickupAddress1,
                                  contentPadding: EdgeInsets.zero,
                                  onChanged: (value) {
                                    if (value != null) {
                                      _isPickupAddress1 = value;
                                      setState(() {});
                                    }
                                  },
                                  title: Text(
                                    pickUpAddress2,
                                    style: black12400.copyWith(
                                        color: mainBlack.withOpacity(0.6)),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                  RadioListTile(
                    value: DeliveryMethod.delivery,
                    groupValue: deliveryMethod,
                    activeColor: accentColor,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (value) {
                      if (value != null) {
                        deliveryMethod = value;
                        clearPickUpAddress();
                      }
                    },
                    title: Text(
                      'Delivery',
                      style: black14500,
                    ),
                  ),
                  const Height8(),
                  AnimatedSize(
                    alignment: Alignment.bottomLeft,
                    duration: const Duration(
                        milliseconds: 300), // Duration of the animation
                    child: deliveryMethod == DeliveryMethod.delivery
                        ? TextField(
                            controller: _deliveryAddress,
                            maxLines: 3,
                            style: const TextStyle(fontSize: 13),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  const Height8(),
                  const Height8(),
                  const Height8(),
                  Text(
                    'Contact',
                    style: black14500,
                  ),
                  const Height8(),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 2 / 3,
                    child: TextField(
                      controller: _phone1,
                      style: const TextStyle(fontSize: 12),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [PhoneNumberInputFormatter()],
                      decoration: InputDecoration(
                        hintText: 'Phone nos 1',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const Height8(),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 2 / 3,
                    child: TextField(
                      controller: _phone2,
                      style: const TextStyle(fontSize: 12),
                      inputFormatters: [PhoneNumberInputFormatter()],
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Phone nos 2',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const Height8(),
                  const Height8(),
                  const Height8(),
                  PrimaryButton(
                    label: 'Complete Order',
                    onPressed: () {
                      if (isValid) {
                        final contactDetails = OrderContactDetails(
                          deliveryMethod: deliveryMethod!,
                          phone1: _phone1.text,
                          phone2: _phone2.text,
                          deliveryAddress: _deliveryAddress.text.isNotEmpty
                              ? _deliveryAddress.text
                              : null,
                          pickupLocation: pickUpAddress,
                        );
                        context
                            .read<AppStateNotifier>()
                            .setContactDetails(contactDetails);
                        Navigator.of(context).pushNamed(paymentPage);
                      }
                    },
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

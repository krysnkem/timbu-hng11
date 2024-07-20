import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_bag_app/data/model/card_details/card_details.dart';
import 'package:shop_bag_app/screens/orders_history.dart';
import 'package:shop_bag_app/screens/widgets/height8.dart';
import 'package:shop_bag_app/screens/widgets/malltiverse_icon_widget.dart';
import 'package:shop_bag_app/utils/extensions.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int index = ModalRoute.of(context)!.settings.arguments as int;
    final order = context.allOrders[index];
    var title = 'Order ${order.orderRef}';
    return Scaffold(
      appBar: StandardAppBar(title: title),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: MalltiverseIconWidget(
                  width: 100,
                ),
              ),
              const Height8(),
              const Height8(),
              detailRow('Order Reference:', order.orderRef),
              detailRow('Date:',
                  '${DateFormat.yMMMd().format(order.date)} ${DateFormat.jm().format(order.date)}'),
              detailRow('Subtotal:', '$currency${order.subTotal}'),
              detailRow('Delivery Fee:', '$currency${order.deliveryFee}'),
              detailRow('Discount Amount:', '$currency${order.discountAmount}'),
              detailRow('Discount Percent:', '${order.discountPercent}%'),
              detailRow('Total Amount:', '$currency${order.totalAmount}'),
              detailRow('Discount Code:', order.discountCode),
              const SizedBox(height: 32),
              Text('Items:', style: black14600),
              ...order.items.map(
                (item) => ListTile(
                  title: Text(
                    item.product.name,
                    style: black14400,
                  ),
                  subtitle: detailRow(
                      '$currency ${item.product.price.toInt().toString().formattedAmount} x ${item.quantity}',
                      'Cost: $currency ${(item.quantity * item.product.price).toInt().toString().formattedAmount}'),
                ),
              ),
              const SizedBox(height: 32),
              Text('Contact Details:', style: black14600),
              detailRow('Phone 1:', order.contactDetails.phone1),
              detailRow('Phone 2:', order.contactDetails.phone2),
              detailRow(
                  'Delivery Method:', order.contactDetails.deliveryMethod.name),
              if (order.contactDetails.pickupLocation != null)
                detailRow(
                  'Pickup Location:',
                  order.contactDetails.pickupLocation!,
                  isExpanded: false,
                ),
              if (order.contactDetails.deliveryAddress != null)
                detailRow(
                  'Delivery Address:',
                  '${order.contactDetails.deliveryAddress}',
                  isExpanded: false,
                ),
              const SizedBox(height: 32),
              Builder(builder: (context) {
                final paymentDetails = order.paymentDetails.type == 'card'
                    ? order.paymentDetails.detail as CardDetails
                    : throw UnimplementedError();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Payment Details:', style: black14600),
                    detailRow(
                      'Card Holder Name:',
                      paymentDetails.cardHolderName,
                    ),
                    detailRow('Expiry Date:', paymentDetails.expiryDate),
                    detailRow('Card Number:', paymentDetails.cardNumber),
                    detailRow('CVV:', paymentDetails.cvv),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailRow(String label, String value, {bool isExpanded = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(label, style: black14400)),
          Expanded(
            child: Text(
              value,
              style: black14500,
              overflow: isExpanded ? TextOverflow.ellipsis : null,
              maxLines: isExpanded ? 1 : null,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class StandardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StandardAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: black19600,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

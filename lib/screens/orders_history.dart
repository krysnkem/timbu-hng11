import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shop_bag_app/screens/home_flow.dart';
import 'package:shop_bag_app/screens/order_detail.dart';
import 'package:shop_bag_app/screens/widgets/app_circular_progress_indicator.dart';
import 'package:shop_bag_app/state/order_state_notifier.dart';
import 'package:shop_bag_app/utils/extensions.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

const currency = '₦';

class OrdersHistory extends StatelessWidget {
  const OrdersHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StandardAppBar(
        title: 'My Orders',
      ),
      body: Builder(
        builder: (context) {
          if (context.loadingOrders) {
            return RefreshIndicator(
              onRefresh: () async =>
                  (context).read<OrderStateNotifier>().loadAllOrders(),
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 3,
                  ),
                  const Center(
                    child: AppCircularProgressIndicator(),
                  )
                ],
              ),
            );
          }
          if (context.allOrders.isEmpty) {
            return Center(
              child: Text(
                'Orders will show here',
                style: black24500,
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async =>
                (context).read<OrderStateNotifier>().loadAllOrders(),
            child: ListView.builder(
              itemCount: context.allOrders.length,
              itemBuilder: (context, index) {
                return Builder(builder: (context) {
                  final order = context.allOrders[index];
                  final formattedDate =
                      DateFormat.yMMMd().format(order.date); // Format the date
                  final formattedTime =
                      DateFormat.jm().format(order.date); // Format the time
                  return ListTile(
                    title: Text('Order ${order.orderRef}', style: black14500),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            'Total: $currency ${order.totalAmount.toString().formattedAmount}',
                            style: black14500),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(formattedDate, style: grey14500),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(formattedTime, style: grey14500),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        orderDetail,
                        arguments: index, // Pass the index as an argument
                      );
                    },
                  );
                });
              },
            ),
          );
        },
      ),
    );
  }
}

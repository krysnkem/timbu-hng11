import 'package:equatable/equatable.dart';
import 'package:shop_bag_app/data/model/order_item/order_item.dart';

class OrderState extends Equatable {
  final List<OrderItem> allOrders;
  final bool gettingOrders;
  final bool creatingOrder;

  const OrderState({
    this.allOrders = const [],
    this.creatingOrder = false,
    this.gettingOrders = false,
  });

  OrderState copyWith({
    List<OrderItem>? allOrders,
    bool? gettingOrders,
    bool? creatingOrder,
  }) {
    return OrderState(
      allOrders: allOrders ?? this.allOrders,
      creatingOrder: creatingOrder ?? this.creatingOrder,
      gettingOrders: gettingOrders ?? this.gettingOrders,
    );
  }

  @override
  List<Object?> get props => [allOrders, creatingOrder, gettingOrders];
}

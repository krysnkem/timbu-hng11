import 'package:hive/hive.dart';
import 'package:shop_bag_app/data/model/order_item/order_item.dart';
import 'package:shop_bag_app/utils/hive_box_names.dart';

class OrdersDbClient {
  OrdersDbClient._();
  static const String _boxName = ordersBox;

  static Box<OrderItem>? _box;

  static Future<Box<OrderItem>> openBox() async {
    _box = await Hive.openBox<OrderItem>(_boxName);
    return _box!;
  }

  static Future<void> addOrder(OrderItem order) async {
    await _box!.put(order.id, order);
  }

  static Future<OrderItem?> getOrder(String id) async {
    return _box!.get(id);
  }

  static Future<void> deleteOrder(String id) async {
    await _box!.delete(id);
  }

  static Future<List<OrderItem>> getAllOrders() async {
    return _box!.values.toList();
  }

  static Future<void> deleteAll() async {
    await _box!.clear();
  }
}

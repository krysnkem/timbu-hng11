import 'package:hive/hive.dart';
import 'package:shop_bag_app/data/model/cart_item/cart_item.dart';
import 'package:shop_bag_app/utils/hive_box_names.dart';

class CartDbClient {
  CartDbClient._();
  static const String _boxName = cartBox;

  static Box<CartItem>? _box;

  static Future<Box<CartItem>> openBox() async {
    _box = await Hive.openBox<CartItem>(_boxName);
    return _box!;
  }

  static Future<void> addToCart(CartItem order) async {
    await _box!.put(order.product.id, order);
  }

  static Future<CartItem?> getCartItem(String id) async {
    return _box!.get(id);
  }

  static Future<void> deleteFromCart(String id) async {
    await _box!.delete(id);
  }

  static Future<void> deleteAllFromCart() async {
    await _box!.clear();
  }

  static Future<List<CartItem>> getAllItems() async {
    return _box!.values.toList();
  }
}

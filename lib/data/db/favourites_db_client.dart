import 'package:hive/hive.dart';
import 'package:shop_bag_app/data/model/product/product.dart';
import 'package:shop_bag_app/utils/hive_box_names.dart';

class FavouritesDbClient {
  FavouritesDbClient._();
  static const String _boxName = favouriteBox;

  static Box<Product>? _box;

  static Future<Box<Product>> openBox() async {
    _box = await Hive.openBox<Product>(_boxName);
    return _box!;
  }

  static Future<void> addToFavourite(Product order) async {
    await _box!.put(order.id, order);
  }

  static Future<Product?> getFavourite(String id) async {
    return _box!.get(id);
  }

  static Future<void> deleteFavourite(String id) async {
    await _box!.delete(id);
  }

  static Future<List<Product>> getAllFavourites() async {
    return _box!.values.toList();
  }

  static Future<void> deleteAll() async {
    await _box!.clear();
  }
}

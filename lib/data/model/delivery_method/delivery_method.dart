
import 'package:hive/hive.dart';

part 'delivery_method.g.dart';

@HiveType(typeId: 6)
enum DeliveryMethod {
   @HiveField(0)
  pickup,
   @HiveField(1)
  delivery,
}

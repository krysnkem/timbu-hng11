// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderItemAdapter extends TypeAdapter<OrderItem> {
  @override
  final int typeId = 8;

  @override
  OrderItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderItem(
      id: fields[0] as String,
      orderRef: fields[1] as String,
      date: fields[2] as DateTime,
      subTotal: fields[3] as int,
      deliveryFee: fields[4] as int,
      discountAmount: fields[5] as int,
      discountPercent: fields[6] as int,
      totalAmount: fields[7] as int,
      discountCode: fields[8] as String,
      items: (fields[9] as List).cast<CartItem>(),
      contactDetails: fields[10] as OrderContactDetails,
      paymentDetails: fields[11] as PaymentDetails,
    );
  }

  @override
  void write(BinaryWriter writer, OrderItem obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.orderRef)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.subTotal)
      ..writeByte(4)
      ..write(obj.deliveryFee)
      ..writeByte(5)
      ..write(obj.discountAmount)
      ..writeByte(6)
      ..write(obj.discountPercent)
      ..writeByte(7)
      ..write(obj.totalAmount)
      ..writeByte(8)
      ..write(obj.discountCode)
      ..writeByte(9)
      ..write(obj.items)
      ..writeByte(10)
      ..write(obj.contactDetails)
      ..writeByte(11)
      ..write(obj.paymentDetails);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

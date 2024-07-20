// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_order.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PreOrderAdapter extends TypeAdapter<PreOrder> {
  @override
  final int typeId = 3;

  @override
  PreOrder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PreOrder(
      subTotal: fields[0] as int,
      deliveryFee: fields[1] as int,
      discountAmount: fields[2] as int,
      discountPercent: fields[3] as int,
      totalAmount: fields[4] as int,
      discountCode: fields[5] as String,
      items: (fields[6] as List).cast<CartItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, PreOrder obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.subTotal)
      ..writeByte(1)
      ..write(obj.deliveryFee)
      ..writeByte(2)
      ..write(obj.discountAmount)
      ..writeByte(3)
      ..write(obj.discountPercent)
      ..writeByte(4)
      ..write(obj.totalAmount)
      ..writeByte(5)
      ..write(obj.discountCode)
      ..writeByte(6)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreOrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

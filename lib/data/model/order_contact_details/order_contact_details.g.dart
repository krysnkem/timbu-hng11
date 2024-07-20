// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_contact_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderContactDetailsAdapter extends TypeAdapter<OrderContactDetails> {
  @override
  final int typeId = 7;

  @override
  OrderContactDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderContactDetails(
      deliveryMethod: fields[0] as DeliveryMethod,
      pickupLocation: fields[1] as String?,
      deliveryAddress: fields[2] as String?,
      phone1: fields[3] as String,
      phone2: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OrderContactDetails obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.deliveryMethod)
      ..writeByte(1)
      ..write(obj.pickupLocation)
      ..writeByte(2)
      ..write(obj.deliveryAddress)
      ..writeByte(3)
      ..write(obj.phone1)
      ..writeByte(4)
      ..write(obj.phone2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderContactDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

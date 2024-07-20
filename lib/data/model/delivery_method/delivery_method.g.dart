// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_method.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeliveryMethodAdapter extends TypeAdapter<DeliveryMethod> {
  @override
  final int typeId = 6;

  @override
  DeliveryMethod read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DeliveryMethod.pickup;
      case 1:
        return DeliveryMethod.delivery;
      default:
        return DeliveryMethod.pickup;
    }
  }

  @override
  void write(BinaryWriter writer, DeliveryMethod obj) {
    switch (obj) {
      case DeliveryMethod.pickup:
        writer.writeByte(0);
        break;
      case DeliveryMethod.delivery:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryMethodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

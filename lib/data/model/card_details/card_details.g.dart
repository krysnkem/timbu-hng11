// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardDetailsAdapter extends TypeAdapter<CardDetails> {
  @override
  final int typeId = 4;

  @override
  CardDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardDetails(
      cardHolderName: fields[0] as String,
      expiryDate: fields[1] as String,
      cardNumber: fields[2] as String,
      cvv: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CardDetails obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.cardHolderName)
      ..writeByte(1)
      ..write(obj.expiryDate)
      ..writeByte(2)
      ..write(obj.cardNumber)
      ..writeByte(3)
      ..write(obj.cvv);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

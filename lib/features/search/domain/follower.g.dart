// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follower.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FollowerAdapter extends TypeAdapter<Follower> {
  @override
  final int typeId = 0;

  @override
  Follower read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Follower(
      login: fields[0] as String,
      avatarUrl: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Follower obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.login)
      ..writeByte(1)
      ..write(obj.avatarUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FollowerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

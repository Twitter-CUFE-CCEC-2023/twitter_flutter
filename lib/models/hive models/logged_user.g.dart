// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logged_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoggedUserAdapter extends TypeAdapter<LoggedUser> {
  @override
  final int typeId = 1;

  @override
  LoggedUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoggedUser()
      ..access_token = fields[0] as String
      ..username = fields[1] as String
      ..token_expiration_date = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, LoggedUser obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.access_token)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.token_expiration_date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoggedUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

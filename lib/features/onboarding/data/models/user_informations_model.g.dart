// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_informations_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserInformationsModelAdapter extends TypeAdapter<UserInformationsModel> {
  @override
  final int typeId = 0;

  @override
  UserInformationsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserInformationsModel(
      isMale: fields[0] as bool?,
      heightCm: fields[1] as int?,
      weightKg: fields[3] as int?,
      bornDate: fields[5] as BornDate?,
      activityLevel: fields[6] as String?,
      goal: fields[7] as String?,
      desiredWeightKg: fields[8] as double?,
      rolloverCalories: fields[12] as bool?,
      weeklyGoalInKg: fields[10] as double?,
      weeklyGoalInLb: fields[11] as double?,
      heightFt: fields[2] as double?,
      weightLb: fields[4] as int?,
      desiredWeightLb: fields[9] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, UserInformationsModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.isMale)
      ..writeByte(1)
      ..write(obj.heightCm)
      ..writeByte(2)
      ..write(obj.heightFt)
      ..writeByte(3)
      ..write(obj.weightKg)
      ..writeByte(4)
      ..write(obj.weightLb)
      ..writeByte(5)
      ..write(obj.bornDate)
      ..writeByte(6)
      ..write(obj.activityLevel)
      ..writeByte(7)
      ..write(obj.goal)
      ..writeByte(8)
      ..write(obj.desiredWeightKg)
      ..writeByte(9)
      ..write(obj.desiredWeightLb)
      ..writeByte(10)
      ..write(obj.weeklyGoalInKg)
      ..writeByte(11)
      ..write(obj.weeklyGoalInLb)
      ..writeByte(12)
      ..write(obj.rolloverCalories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInformationsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BornDateAdapter extends TypeAdapter<BornDate> {
  @override
  final int typeId = 1;

  @override
  BornDate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BornDate(
      day: fields[0] as int,
      month: fields[1] as int,
      year: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, BornDate obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.month)
      ..writeByte(2)
      ..write(obj.year);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BornDateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

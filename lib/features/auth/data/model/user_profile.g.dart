// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 2;

  @override
  UserProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfile(
      userId: fields[0] as String,
      fullName: fields[1] as String?,
      email: fields[2] as String?,
      dailyCalorieGoal: fields[3] as int?,
      dailyProteinGoal: fields[4] as int?,
      dailyCarbGoal: fields[5] as int?,
      dailyFatGoal: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.fullName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.dailyCalorieGoal)
      ..writeByte(4)
      ..write(obj.dailyProteinGoal)
      ..writeByte(5)
      ..write(obj.dailyCarbGoal)
      ..writeByte(6)
      ..write(obj.dailyFatGoal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      userId: json['id'] as String,
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      dailyCalorieGoal: (json['daily_calorie_goal'] as num?)?.toInt(),
      dailyProteinGoal: (json['daily_protein_goal'] as num?)?.toInt(),
      dailyCarbGoal: (json['daily_carbs_goal'] as num?)?.toInt(),
      dailyFatGoal: (json['daily_fats_goal'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'id': instance.userId,
      'full_name': instance.fullName,
      'email': instance.email,
      'daily_calorie_goal': instance.dailyCalorieGoal,
      'daily_protein_goal': instance.dailyProteinGoal,
      'daily_carbs_goal': instance.dailyCarbGoal,
      'daily_fats_goal': instance.dailyFatGoal,
    };

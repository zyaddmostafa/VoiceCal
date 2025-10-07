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
      userId: fields[0] as String?,
      fullName: fields[1] as String?,
      email: fields[2] as String?,
      dailyCalorieGoal: fields[3] as int?,
      dailyProteinGoal: fields[4] as int?,
      dailyCarbGoal: fields[5] as int?,
      dailyFatGoal: fields[6] as int?,
      height: fields[7] as double?,
      weight: fields[8] as double?,
      isMale: fields[9] as bool?,
      bornDate: fields[10] as String?,
      activityLevel: fields[11] as String?,
      weeklyGoalInKg: fields[12] as double?,
      rolloverCalories: fields[13] as bool?,
      goal: fields[14] as String?,
      desiredWeightInKg: fields[15] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer
      ..writeByte(16)
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
      ..write(obj.dailyFatGoal)
      ..writeByte(7)
      ..write(obj.height)
      ..writeByte(8)
      ..write(obj.weight)
      ..writeByte(9)
      ..write(obj.isMale)
      ..writeByte(10)
      ..write(obj.bornDate)
      ..writeByte(11)
      ..write(obj.activityLevel)
      ..writeByte(12)
      ..write(obj.weeklyGoalInKg)
      ..writeByte(13)
      ..write(obj.rolloverCalories)
      ..writeByte(14)
      ..write(obj.goal)
      ..writeByte(15)
      ..write(obj.desiredWeightInKg);
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
      userId: json['id'] as String?,
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      dailyCalorieGoal: (json['daily_calorie_goal'] as num?)?.toInt(),
      dailyProteinGoal: (json['daily_protein_goal'] as num?)?.toInt(),
      dailyCarbGoal: (json['daily_carbs_goal'] as num?)?.toInt(),
      dailyFatGoal: (json['daily_fats_goal'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      isMale: json['is_male'] as bool?,
      bornDate: json['born_date'] as String?,
      activityLevel: json['activity_level'] as String?,
      weeklyGoalInKg: (json['weekly_goal_in_kg'] as num?)?.toDouble(),
      rolloverCalories: json['rollover_calories'] as bool?,
      goal: json['goal'] as String?,
      desiredWeightInKg: (json['desired_weight'] as num?)?.toDouble(),
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
      'height': instance.height,
      'weight': instance.weight,
      'is_male': instance.isMale,
      'born_date': instance.bornDate,
      'activity_level': instance.activityLevel,
      'weekly_goal_in_kg': instance.weeklyGoalInKg,
      'rollover_calories': instance.rolloverCalories,
      'goal': instance.goal,
      'desired_weight': instance.desiredWeightInKg,
    };

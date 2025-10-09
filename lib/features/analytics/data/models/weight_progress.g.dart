// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeightProgress _$WeightProgressFromJson(Map<String, dynamic> json) =>
    WeightProgress(
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      currentWeight: (json['current_weight'] as num?)?.toDouble(),
      startingWeight: (json['starting_weight'] as num?)?.toDouble(),
      weightChange: (json['weight_change'] as num?)?.toDouble(),
      entries: (json['entries'] as List<dynamic>)
          .map((e) => WeightEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeightProgressToJson(WeightProgress instance) =>
    <String, dynamic>{
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'current_weight': instance.currentWeight,
      'starting_weight': instance.startingWeight,
      'weight_change': instance.weightChange,
      'entries': instance.entries,
    };

WeightEntry _$WeightEntryFromJson(Map<String, dynamic> json) => WeightEntry(
      date: json['date'] as String,
      weight: (json['weight'] as num).toDouble(),
    );

Map<String, dynamic> _$WeightEntryToJson(WeightEntry instance) =>
    <String, dynamic>{
      'date': instance.date,
      'weight': instance.weight,
    };

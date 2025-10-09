import 'package:json_annotation/json_annotation.dart';
import 'weight_entry.dart' as old_weight_entry;

part 'weight_progress.g.dart';

@JsonSerializable()
class WeightProgress {
  @JsonKey(name: 'start_date')
  final String startDate;
  @JsonKey(name: 'end_date')
  final String endDate;
  @JsonKey(name: 'current_weight')
  final double? currentWeight;
  @JsonKey(name: 'starting_weight')
  final double? startingWeight;
  @JsonKey(name: 'weight_change')
  final double? weightChange;
  final List<WeightEntry> entries;

  WeightProgress({
    required this.startDate,
    required this.endDate,
    this.currentWeight,
    this.startingWeight,
    this.weightChange,
    required this.entries,
  });

  factory WeightProgress.fromJson(Map<String, dynamic> json) =>
      _$WeightProgressFromJson(json);

  Map<String, dynamic> toJson() => _$WeightProgressToJson(this);
}

@JsonSerializable()
class WeightEntry {
  final String date;
  final double weight;

  WeightEntry({required this.date, required this.weight});

  factory WeightEntry.fromJson(Map<String, dynamic> json) =>
      _$WeightEntryFromJson(json);

  Map<String, dynamic> toJson() => _$WeightEntryToJson(this);

  old_weight_entry.WeightEntry toOldWeightEntry({bool isSelected = false}) {
    return old_weight_entry.WeightEntry(
      weight: weight,
      date: DateTime.parse(date),
      isSelected: isSelected,
    );
  }
}

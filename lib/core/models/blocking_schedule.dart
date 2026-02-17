/// Model for blocking schedule configuration
class BlockingSchedule {
  final int startHour;
  final int startMinute;
  final int endHour;
  final int endMinute;
  final bool repeatsDaily;
  final bool isActive;
  final List<int>? daysOfWeek; // 1=Monday, 7=Sunday

  BlockingSchedule({
    required this.startHour,
    required this.startMinute,
    required this.endHour,
    required this.endMinute,
    this.repeatsDaily = false,
    this.isActive = true,
    this.daysOfWeek,
  });

  factory BlockingSchedule.fromJson(Map<String, dynamic> json) {
    return BlockingSchedule(
      startHour: json['startHour'] as int,
      startMinute: json['startMinute'] as int,
      endHour: json['endHour'] as int,
      endMinute: json['endMinute'] as int,
      repeatsDaily: json['repeatsDaily'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      daysOfWeek: (json['daysOfWeek'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startHour': startHour,
      'startMinute': startMinute,
      'endHour': endHour,
      'endMinute': endMinute,
      'repeatsDaily': repeatsDaily,
      'isActive': isActive,
      'daysOfWeek': daysOfWeek,
    };
  }

  String get startTimeFormatted =>
      '${startHour.toString().padLeft(2, '0')}:${startMinute.toString().padLeft(2, '0')}';

  String get endTimeFormatted =>
      '${endHour.toString().padLeft(2, '0')}:${endMinute.toString().padLeft(2, '0')}';

  BlockingSchedule copyWith({
    int? startHour,
    int? startMinute,
    int? endHour,
    int? endMinute,
    bool? repeatsDaily,
    bool? isActive,
    List<int>? daysOfWeek,
  }) {
    return BlockingSchedule(
      startHour: startHour ?? this.startHour,
      startMinute: startMinute ?? this.startMinute,
      endHour: endHour ?? this.endHour,
      endMinute: endMinute ?? this.endMinute,
      repeatsDaily: repeatsDaily ?? this.repeatsDaily,
      isActive: isActive ?? this.isActive,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
    );
  }
}

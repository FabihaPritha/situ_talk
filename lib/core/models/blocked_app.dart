/// Model representing a blocked application
class BlockedApp {
  final String packageName; // Android package name or iOS bundle identifier
  final String appName;
  final String? iconPath;
  final bool isBlocked;
  final DateTime? addedAt;

  BlockedApp({
    required this.packageName,
    required this.appName,
    this.iconPath,
    this.isBlocked = true,
    this.addedAt,
  });

  factory BlockedApp.fromJson(Map<String, dynamic> json) {
    return BlockedApp(
      packageName: json['packageName'] as String,
      appName: json['appName'] as String,
      iconPath: json['iconPath'] as String?,
      isBlocked: json['isBlocked'] as bool? ?? true,
      addedAt: json['addedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['addedAt'] as int)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'packageName': packageName,
      'appName': appName,
      'iconPath': iconPath,
      'isBlocked': isBlocked,
      'addedAt': addedAt?.millisecondsSinceEpoch,
    };
  }

  BlockedApp copyWith({
    String? packageName,
    String? appName,
    String? iconPath,
    bool? isBlocked,
    DateTime? addedAt,
  }) {
    return BlockedApp(
      packageName: packageName ?? this.packageName,
      appName: appName ?? this.appName,
      iconPath: iconPath ?? this.iconPath,
      isBlocked: isBlocked ?? this.isBlocked,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BlockedApp && other.packageName == packageName;
  }

  @override
  int get hashCode => packageName.hashCode;
}

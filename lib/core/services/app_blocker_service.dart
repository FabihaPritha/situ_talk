import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:io';

/// Service to handle app blocking functionality for iOS and Android
/// Uses platform channels to communicate with native code
class AppBlockerService {
  static const MethodChannel _channel = MethodChannel('com.zenith.app_blocker');

  // Singleton pattern
  static final AppBlockerService _instance = AppBlockerService._internal();
  factory AppBlockerService() => _instance;
  AppBlockerService._internal();

  /// Initialize the app blocker service
  /// Returns true if initialization was successful
  Future<bool> initialize() async {
    try {
      final bool result = await _channel.invokeMethod('initialize');
      return result;
    } on PlatformException catch (e) {
      debugPrint('Failed to initialize app blocker: ${e.message}');
      return false;
    }
  }

  /// Request necessary permissions
  /// iOS: Family Controls authorization
  /// Android: Usage Stats + Accessibility Service permissions
  Future<bool> requestPermissions() async {
    try {
      final bool result = await _channel.invokeMethod('requestPermissions');
      return result;
    } on PlatformException catch (e) {
      debugPrint('Failed to request permissions: ${e.message}');
      return false;
    }
  }

  /// Check if all required permissions are granted
  Future<bool> hasPermissions() async {
    try {
      final bool result = await _channel.invokeMethod('hasPermissions');
      return result;
    } on PlatformException catch (e) {
      debugPrint('Failed to check permissions: ${e.message}');
      return false;
    }
  }

  /// Get detailed permission status
  Future<Map<String, bool>> getDetailedPermissions() async {
    try {
      final Map<dynamic, dynamic> result = await _channel.invokeMethod(
        'getDetailedPermissions',
      );
      return result.map(
        (key, value) => MapEntry(key.toString(), value as bool),
      );
    } on PlatformException catch (e) {
      debugPrint('Failed to get detailed permissions: ${e.message}');
      return {
        'usageStats': false,
        'accessibility': false,
        'overlay': false,
        'screenTime': false,
        'allGranted': false,
      };
    }
  }

  /// Open system settings for granting permissions
  /// iOS: Screen Time settings
  /// Android: Usage Stats or Accessibility settings
  Future<void> openPermissionSettings() async {
    try {
      await _channel.invokeMethod('openSettings');
    } on PlatformException catch (e) {
      debugPrint('Failed to open settings: ${e.message}');
    }
  }

  /// Open Accessibility Settings specifically (Android only)
  Future<void> openAccessibilitySettings() async {
    try {
      await _channel.invokeMethod('openAccessibilitySettings');
    } on PlatformException catch (e) {
      debugPrint('Failed to open accessibility settings: ${e.message}');
    }
  }

  /// Show app picker to select apps to block
  /// iOS: Opens FamilyActivityPicker
  /// Android: Returns list of installed apps for custom picker
  Future<List<Map<String, String>>> showAppPicker() async {
    try {
      debugPrint(
        '🔍 showAppPicker called, Platform: ${Platform.isAndroid ? "Android" : "iOS"}',
      );

      if (Platform.isIOS) {
        // iOS will show native FamilyActivityPicker
        debugPrint('📱 Calling iOS showAppPicker...');
        final bool success = await _channel.invokeMethod('showAppPicker');
        debugPrint('📱 iOS showAppPicker result: $success');
        if (success) {
          // Return success indicator - caller should handle loading blocked apps
          return [
            {'success': 'true'},
          ];
        }
        return [];
      } else if (Platform.isAndroid) {
        // Android returns list of installed apps
        debugPrint('🤖 Calling Android getInstalledApps...');
        final List<dynamic> apps = await _channel.invokeMethod(
          'getInstalledApps',
        );
        debugPrint('🤖 Android getInstalledApps returned ${apps.length} apps');

        if (apps.isEmpty) {
          debugPrint('⚠️ WARNING: getInstalledApps returned EMPTY list!');
          debugPrint(
            '⚠️ This might be a permission issue or the native method is not working correctly',
          );
        } else {
          debugPrint('✅ First 3 apps: ${apps.take(3).toList()}');
        }

        return apps.map((app) => Map<String, String>.from(app as Map)).toList();
      }
      return [];
    } on PlatformException catch (e) {
      debugPrint('❌ Failed to show app picker: ${e.message}');
      debugPrint('❌ Error code: ${e.code}');
      debugPrint('❌ Error details: ${e.details}');
      return [];
    } catch (e, stackTrace) {
      debugPrint('❌ Unexpected error in showAppPicker: $e');
      debugPrint('❌ Stack trace: $stackTrace');
      return [];
    }
  }

  /// Set list of apps to block (Android only)
  /// iOS apps are selected via FamilyActivityPicker
  Future<bool> setBlockedApps(List<String> packageNames) async {
    if (Platform.isAndroid) {
      try {
        final bool result = await _channel.invokeMethod('setBlockedApps', {
          'apps': packageNames,
        });
        return result;
      } on PlatformException catch (e) {
        debugPrint('Failed to set blocked apps: ${e.message}');
        return false;
      }
    }
    return false;
  }

  /// Get list of currently blocked apps
  Future<List<Map<String, String>>> getBlockedApps() async {
    try {
      final List<dynamic> apps = await _channel.invokeMethod('getBlockedApps');
      if (Platform.isAndroid) {
        return apps.map((app) => Map<String, String>.from(app as Map)).toList();
      } else {
        // iOS returns app info
        return apps.map((app) => Map<String, String>.from(app as Map)).toList();
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to get blocked apps: ${e.message}');
      return [];
    }
  }

  /// Enable blocking for all selected apps
  Future<bool> enableBlocking() async {
    try {
      final bool result = await _channel.invokeMethod('enableBlocking');
      return result;
    } on PlatformException catch (e) {
      debugPrint('Failed to enable blocking: ${e.message}');
      return false;
    }
  }

  /// Disable blocking for all apps
  Future<bool> disableBlocking() async {
    try {
      final bool result = await _channel.invokeMethod('disableBlocking');
      return result;
    } on PlatformException catch (e) {
      debugPrint('Failed to disable blocking: ${e.message}');
      return false;
    }
  }

  /// Check if blocking is currently active
  Future<bool> isBlockingActive() async {
    try {
      final bool result = await _channel.invokeMethod('isBlockingActive');
      return result;
    } on PlatformException catch (e) {
      debugPrint('Failed to check blocking status: ${e.message}');
      return false;
    }
  }

  /// Save barrier duration for a specific app (seconds)
  Future<bool> saveBarrierDurationForApp(
    String packageName,
    int durationSeconds,
  ) async {
    try {
      final bool result = await _channel.invokeMethod(
        'saveBarrierDurationForApp',
        {'packageName': packageName, 'durationSeconds': durationSeconds},
      );
      return result;
    } on PlatformException catch (e) {
      debugPrint('Failed to save barrier duration: ${e.message}');
      return false;
    }
  }

  /// Get barrier duration for a specific app (seconds)
  Future<int?> getBarrierDurationForApp(String packageName) async {
    try {
      final int? result = await _channel.invokeMethod(
        'getBarrierDurationForApp',
        {'packageName': packageName},
      );
      return result;
    } on PlatformException catch (e) {
      debugPrint('Failed to get barrier duration: ${e.message}');
      return null;
    }
  }

  /// Remove a specific app from blocked list
  Future<bool> removeBlockedApp(String packageName) async {
    try {
      final bool result = await _channel.invokeMethod('removeBlockedApp', {
        'packageName': packageName,
      });
      return result;
    } on PlatformException catch (e) {
      debugPrint('Failed to remove blocked app: ${e.message}');
      return false;
    }
  }

  /// Set breathing exercise duration (in seconds)
  /// This is how long user must complete the exercise before accessing blocked app
  Future<bool> setBreathingDuration(int seconds) async {
    try {
      final bool result = await _channel.invokeMethod('setBreathingDuration', {
        'duration': seconds,
      });
      return result;
    } on PlatformException catch (e) {
      debugPrint('Failed to set breathing duration: ${e.message}');
      return false;
    }
  }

  /// Get app usage statistics (Android only)
  /// Returns map of package names to usage time in milliseconds
  Future<Map<String, int>> getAppUsageStats({
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    if (Platform.isAndroid) {
      try {
        final Map<dynamic, dynamic> stats = await _channel
            .invokeMethod('getAppUsageStats', {
              'startTime': startTime.millisecondsSinceEpoch,
              'endTime': endTime.millisecondsSinceEpoch,
            });
        return Map<String, int>.from(stats);
      } on PlatformException catch (e) {
        debugPrint('Failed to get app usage stats: ${e.message}');
        return {};
      }
    }
    return {};
  }

  /// Schedule blocking for specific time periods
  /// iOS: Uses DeviceActivitySchedule
  /// Android: Uses local scheduling
  Future<bool> scheduleBlocking({
    required int startHour,
    required int startMinute,
    required int endHour,
    required int endMinute,
    bool repeatsDaily = false,
  }) async {
    try {
      final bool result = await _channel.invokeMethod('scheduleBlocking', {
        'startHour': startHour,
        'startMinute': startMinute,
        'endHour': endHour,
        'endMinute': endMinute,
        'repeats': repeatsDaily,
      });
      return result;
    } on PlatformException catch (e) {
      debugPrint('Failed to schedule blocking: ${e.message}');
      return false;
    }
  }

  /// Cancel scheduled blocking
  Future<bool> cancelScheduledBlocking() async {
    try {
      final bool result = await _channel.invokeMethod('cancelSchedule');
      return result;
    } on PlatformException catch (e) {
      debugPrint('Failed to cancel schedule: ${e.message}');
      return false;
    }
  }

  /// Listen for events from native side
  /// E.g., when a blocked app is launched
  Stream<Map<String, dynamic>> get blockedAppLaunchEvents {
    return EventChannel(
      'com.zenith.app_blocker/events',
    ).receiveBroadcastStream().map((event) => Map<String, dynamic>.from(event));
  }

  /// Reset all app sessions (Android only)
  /// Clears all breathing exercise timers and completion status
  /// This allows apps to require breathing exercise again
  Future<bool> resetAllSessions() async {
    if (Platform.isAndroid) {
      try {
        final bool result = await _channel.invokeMethod('resetSessions');
        return result;
      } on PlatformException catch (e) {
        debugPrint('Failed to reset sessions: ${e.message}');
        return false;
      }
    }
    return false;
  }

  /// Start a barrier session for an app (Android only)
  /// This begins the countdown timer from when settings are saved
  /// @param packageName - The package name of the app
  /// @param durationSeconds - The barrier duration in seconds
  Future<bool> startBarrierSession(
    String packageName,
    int durationSeconds,
  ) async {
    if (Platform.isAndroid) {
      try {
        final bool result = await _channel.invokeMethod('startBarrierSession', {
          'packageName': packageName,
          'durationSeconds': durationSeconds,
        });
        return result;
      } on PlatformException catch (e) {
        debugPrint('Failed to start barrier session: ${e.message}');
        return false;
      }
    }
    return false;
  }

  /// Test overlay display (Android only, for debugging)
  Future<bool> testOverlay() async {
    if (Platform.isAndroid) {
      try {
        final bool result = await _channel.invokeMethod('testOverlay');
        return result;
      } on PlatformException catch (e) {
        debugPrint('Failed to test overlay: ${e.message}');
        return false;
      }
    }
    return false;
  }

  /// Check service status (Android only, for debugging)
  Future<Map<String, dynamic>> checkServiceStatus() async {
    if (Platform.isAndroid) {
      try {
        final Map<Object?, Object?> status = await _channel.invokeMethod(
          'checkServiceStatus',
        );
        return status.cast<String, dynamic>();
      } on PlatformException catch (e) {
        debugPrint('Failed to check service status: ${e.message}');
      }
    }
    return {};
  }

  /// Request overlay permission directly (Android only)
  /// Opens the specific settings page for "Display over other apps"
  Future<bool> requestOverlayPermission() async {
    if (Platform.isAndroid) {
      try {
        final bool result = await _channel.invokeMethod(
          'requestOverlayPermission',
        );
        return result;
      } on PlatformException catch (e) {
        debugPrint('Failed to request overlay permission: ${e.message}');
        return false;
      }
    }
    return true; // iOS doesn't need this
  }

  /// Check if overlay permission is granted (Android only)
  Future<bool> hasOverlayPermission() async {
    if (Platform.isAndroid) {
      try {
        final bool result = await _channel.invokeMethod('canDrawOverlays');
        return result;
      } on PlatformException catch (e) {
        debugPrint('Failed to check overlay permission: ${e.message}');
        return false;
      }
    }
    return true; // iOS doesn't need this
  }

  /// Notify native layer (Android/iOS) about permission status from backend
  /// This allows native code to know the permission state for proper blocking
  Future<bool> notifyPermissionStatus({
    required bool usageStats,
    required bool accessibility,
    required bool overlay,
    required bool notificationListener,
    required bool allGranted,
  }) async {
    try {
      final bool result = await _channel
          .invokeMethod('notifyPermissionStatus', {
            'usageStats': usageStats,
            'accessibility': accessibility,
            'overlay': overlay,
            'notificationListener': notificationListener,
            'allGranted': allGranted,
          });
      return result;
    } on PlatformException catch (e) {
      debugPrint('Failed to notify permission status: ${e.message}');
      return false;
    }
  }
}

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Service to listen for OS-level permission changes
/// Monitors permission status changes in real-time
class PermissionListenerService {
  static const MethodChannel _channel = MethodChannel(
    'com.zenith.permission_listener',
  );
  static const EventChannel _eventChannel = EventChannel(
    'com.zenith.permission_listener/events',
  );

  // Singleton pattern
  static final PermissionListenerService _instance =
      PermissionListenerService._internal();
  factory PermissionListenerService() => _instance;
  PermissionListenerService._internal();

  StreamSubscription<dynamic>? _subscription;
  final _permissionChangeController =
      StreamController<Map<String, bool>>.broadcast();

  /// Stream of permission changes
  /// Emits a map of permission states whenever any permission changes
  Stream<Map<String, bool>> get permissionChanges =>
      _permissionChangeController.stream;

  /// Start listening for permission changes
  Future<bool> startListening() async {
    if (_subscription != null) {
      debugPrint('⚠️ Permission listener already active');
      return true;
    }

    try {
      // Start native listeners
      final bool started = await _channel.invokeMethod(
        'startPermissionListener',
      );

      if (!started) {
        debugPrint('❌ Failed to start permission listener');
        return false;
      }

      // Subscribe to permission change events
      _subscription = _eventChannel.receiveBroadcastStream().listen(
        (dynamic event) {
          try {
            final Map<String, dynamic> eventMap = Map<String, dynamic>.from(
              event,
            );
            debugPrint('📡 Permission change detected: $eventMap');

            // Convert to Map<String, bool>
            final permissionStatus = <String, bool>{};
            eventMap.forEach((key, value) {
              if (value is bool) {
                permissionStatus[key] = value;
              }
            });

            // Emit the change
            _permissionChangeController.add(permissionStatus);
          } catch (e) {
            debugPrint('❌ Error processing permission change event: $e');
          }
        },
        onError: (error) {
          debugPrint('❌ Permission listener error: $error');
        },
      );

      debugPrint('✅ Permission listener started successfully');
      return true;
    } on PlatformException catch (e) {
      debugPrint('❌ Failed to start permission listener: ${e.message}');
      return false;
    }
  }

  /// Stop listening for permission changes
  Future<void> stopListening() async {
    try {
      await _subscription?.cancel();
      _subscription = null;

      await _channel.invokeMethod('stopPermissionListener');
      debugPrint('✅ Permission listener stopped');
    } on PlatformException catch (e) {
      debugPrint('❌ Failed to stop permission listener: ${e.message}');
    }
  }

  /// Check current permission status (one-time check)
  Future<Map<String, bool>> checkPermissions() async {
    try {
      final Map<dynamic, dynamic> result = await _channel.invokeMethod(
        'checkPermissions',
      );
      return result.map(
        (key, value) => MapEntry(key.toString(), value as bool),
      );
    } on PlatformException catch (e) {
      debugPrint('❌ Failed to check permissions: ${e.message}');
      return {
        'usageStats': false,
        'accessibility': false,
        'overlay': false,
        'screenTime': false,
        'allGranted': false,
      };
    }
  }

  /// Dispose resources
  void dispose() {
    stopListening();
    _permissionChangeController.close();
  }
}

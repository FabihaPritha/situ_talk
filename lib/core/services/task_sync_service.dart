import 'package:flutter/services.dart';

/// Service to sync task completion status between Flutter and native code
/// This ensures that the AccessibilityService can check if apps should be blocked
class TaskSyncService {
  static const _taskSyncChannel = MethodChannel('com.zenith.myapp/task_sync');

  /// Sync task completion count to native code
  /// This is called whenever tasks are completed/uncompleted
  static Future<bool> syncTaskCompletion({
    required int completedTasks,
    required int totalTasks,
    required List<Map<String, dynamic>> tasks,
  }) async {
    try {
      print('📤 ========== Syncing Tasks to Native ==========');
      print('   Completed: $completedTasks');
      print('   Total: $totalTasks');
      print('   Unlocked: ${completedTasks >= 5}');
      print('   Tasks: ${tasks.length} tasks');

      final result = await _taskSyncChannel.invokeMethod('syncTasks', {
        'tasks': tasks,
        'completed_tasks': completedTasks,
        'total_tasks': totalTasks,
        'apps_unlocked': completedTasks >= 5,
      });

      if (result == true) {
        print('✅ Task sync successful');
        return true;
      } else {
        print('⚠️ Task sync returned false');
        return false;
      }
    } catch (e) {
      print('❌ Error syncing tasks: $e');
      return false;
    }
  }

  /// Get task completion status from native code
  static Future<Map<String, dynamic>?> getTaskStatus() async {
    try {
      print('📥 Fetching task status from native');

      final result = await _taskSyncChannel.invokeMethod('getTaskStatus');

      if (result != null && result is Map) {
        final status = Map<String, dynamic>.from(result);
        print('✅ Task status retrieved:');
        print('   Completed: ${status['completed_tasks']}');
        print('   Total: ${status['total_tasks']}');
        print('   Unlocked: ${status['apps_unlocked']}');
        return status;
      }

      print('⚠️ No task status available from native');
      return null;
    } catch (e) {
      print('❌ Error getting task status: $e');
      return null;
    }
  }

  /// Reset tasks at midnight (can be called from native alarm)
  static Future<void> resetTasks() async {
    try {
      print('🔄 Resetting tasks for new day');
      await _taskSyncChannel.invokeMethod('resetTasks');
      print('✅ Tasks reset successfully');
    } catch (e) {
      print('❌ Error resetting tasks: $e');
    }
  }
}

import 'package:get/get.dart';

class ProgressController extends GetxController {
  // Mastery and XP data
  var masteryPercentage = 65.obs;
  var currentLevel = 4.obs;
  var nextLevelXP = 250.obs;
  var currentXPProgress = 0.7.obs; // 70% towards next level

  // Situations Breakdown
  var totalSituations = 40.obs;
  var completedSituations = 25.obs;
  var inProgressSituations = 5.obs;
  var notStartedSituations = 10.obs;

  // Recent Activity List
  final List<Map<String, dynamic>> recentActivities = [
    {"title": "At the Airport", "time": "Completed yesterday", "score": "95%"},
    {"title": "Ordering Coffee", "time": "Completed 2 days ago", "score": "100%"},
    {"title": "Hotel Check-in", "time": "Completed 4 days ago", "score": "80%"},
  ].obs;
}
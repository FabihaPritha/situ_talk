import 'package:get/get.dart';

class HomeController extends GetxController {
  var userName = "John".obs;
  var streakCount = 7.obs;
  var totalPoints = 250.obs;
  var notificationCount = 3.obs; // Logic for the red dot badge

  void openSettings() => print("Settings opened");
  void openNotifications() => print("Notifications opened");
}

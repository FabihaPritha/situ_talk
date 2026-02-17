class ApiConstants {
  // Base URL - Replace with your actual backend URL
  static const String baseUrl = 'https://zenith-be-n1of.onrender.com/api/v1';

  // API Endpoints

  //Auth APIs
  static const String googleSignin = '$baseUrl/auth/google';
  static const String appleSignin = '$baseUrl/auth/apple';
  static const String refreshToken = '$baseUrl/auth/refresh';
  static const String logout = '$baseUrl/auth/logout';

  //Profile APIs
  static const String getProfile = '$baseUrl/auth/me';

  //getTask
  static const String getTasks = '$baseUrl/tasks';
  static const String createTask = '$baseUrl/tasks';
  static String updateTask(String taskId) =>
      '$baseUrl/tasks/$taskId';
  // static const String deleteTask(String taskId '$baseUrl/tasks';

  //blocked apps and app restrictions
  static const String getBlockedApps = '$baseUrl/app-blocking/apps';
  static const String addBlockedApp = '$baseUrl/app-blocking/apps';
  static String deleteBlockedApp(String appId) =>
      '$baseUrl/app-blocking/apps/$appId';
  static String toggleBlockedApp(String appId) =>
      '$baseUrl/app-blocking/apps/$appId/toggle';
  static String toggleRestrictedApp(String appId) =>
      '$baseUrl/app-blocking/restricted-apps/$appId/toggle';

  //permission status
  static const String getPermissionStatus = '$baseUrl/app-blocking/permissions';
  static const String postPermissionStatus =
      '$baseUrl/app-blocking/permissions';
  static String updatePermissionStatus(String permissionId) =>
      '$baseUrl/app-blocking/permissions/$permissionId';

  //statistics
  static const String getUsageStatistics = '$baseUrl/app-blocking/statistics';

  static const String syncBlockedApps = '/users/{userId}/blocked-apps/sync';

  static const String toggleAppRestriction =
      '/users/{userId}/blocked-apps/{appId}';
  static const String getSettings = '/users/{userId}/settings/app-restrictions';
  static const String updateSettings =
      '/users/{userId}/settings/app-restrictions';
  static const String logUsageEvent = '/users/{userId}/app-usage/events';
  static const String registerDevice = '/users/{userId}/devices';
}

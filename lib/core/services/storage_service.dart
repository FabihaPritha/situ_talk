// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:jamondes/core/utils/jwt_utils.dart';

// class StorageService {
//   StorageService._();

//   static bool? isLoggedIn;
//   static SharedPreferences? _preferences;

//   static const String _isLoggedInKey = 'isLoggedIn';
//   static const String _tokenKey = 'token';
//   static const String _refreshTokenKey = 'refreshToken';
//   static const String _sessionIdKey = 'sessionId';
//   static const String _seenOnboardingKey = 'seenOnboarding';
//   static const String _userIdKey = 'userId';
//   static const String _firstNameKey = 'firstName';
//   static const String _lastNameKey = 'lastName';
//   static const String _emailKey = 'email';
//   static const String _phoneNumberKey = 'phoneNumber';
//   static const String _passwordKey = 'password';
//   static const String _provider = 'provider';
//   static const String _fcmTokenKey = 'fcmToken';
//   static const String _userProfileKey = 'userProfile';
//   static const String _chatRoomIdKey = 'chatRoomId';
//   static const String _healthContextCacheKey = 'healthContextCache';
//   static const String _healthContextTimestampKey = 'healthContextTimestamp';

//   static Future<void> init() async {
//     _preferences = await SharedPreferences.getInstance();
//     await checkLoggedIn();

//     // Verify initialization with detailed logging
//     final token = _preferences?.getString(_tokenKey);
//     final userId = _preferences?.getString(_userIdKey);
//     final seenOnboarding = _preferences?.getBool(_seenOnboardingKey) ?? false;

//     debugPrint('📋 StorageService initialized:');
//     debugPrint('   • isLoggedIn: $isLoggedIn');
//     debugPrint('   • Has token: ${token != null}');
//     debugPrint('   • Has userId: ${userId != null}');
//     debugPrint('   • seenOnboarding: $seenOnboarding');
//   }

//   static Future<void> checkLoggedIn() async {
//     isLoggedIn = _preferences?.getBool(_isLoggedInKey) ?? false;
//     debugPrint('🔍 Checked login status: $isLoggedIn');
//   }

//   static bool hasSeenOnboarding() {
//     return _preferences?.getBool(_seenOnboardingKey) ?? false;
//   }

//   static Future<void> setSeenOnboarding() async {
//     await _preferences?.setBool(_seenOnboardingKey, true);
//     debugPrint('✅ Marked onboarding as seen');
//   }

//   /// Check if this is a brand new user (first time signup)
//   /// Returns true if user is logged in but hasn't seen onboarding
//   static bool isFirstTimeUser() {
//     final loggedIn = isLoggedIn ?? false;
//     final seenOnboarding = hasSeenOnboarding();
//     return loggedIn && !seenOnboarding;
//   }

//   static Future<void> makeLoggedIn() async {
//     await _preferences?.setBool(_isLoggedInKey, true);
//     // Force a reload to ensure the static variable is in sync
//     await checkLoggedIn();
//     debugPrint('✅ User marked as logged in (verified: $isLoggedIn)');
//   }

//   static Future<void> makeLoggedOut() async {
//     await _preferences?.setBool(_isLoggedInKey, false);
//     // Force a reload to ensure the static variable is in sync
//     await checkLoggedIn();
//     debugPrint('🚪 User marked as logged out');
//     debugPrint('   • isLoggedIn flag verified: $isLoggedIn');
//     debugPrint('   • seenOnboarding flag preserved: ${hasSeenOnboarding()}');
//   }

//   static Future<void> saveToken(String token) async {
//     await _preferences?.setString(_tokenKey, token);
//     debugPrint('Saved access token (${token.length} chars)');
//   }

//   static String? getToken() {
//     return _preferences?.getString(_tokenKey);
//   }

//   /// Get remaining seconds until access token expires
//   /// Returns 0 if already expired, -1 if invalid
//   static int getTokenSecondsUntilExpiry() {
//     final token = _preferences?.getString(_tokenKey);
//     if (token == null || token.isEmpty) return -1;

//     return JwtUtils.getSecondsUntilExpiry(token);
//   }

//   /// Check if access token is expiring soon (within threshold seconds)
//   /// Useful for proactive refresh logic
//   static bool isTokenExpiringSoon({int thresholdSeconds = 60}) {
//     final token = _preferences?.getString(_tokenKey);
//     if (token == null || token.isEmpty) return true;

//     return JwtUtils.isExpiringSoon(token, thresholdSeconds: thresholdSeconds);
//   }

//   static Future<void> saveRefreshToken(String token) async {
//     await _preferences?.setString(_refreshTokenKey, token);
//     debugPrint('Saved refresh token (${token.length} chars)');
//   }

//   static String? getRefreshToken() {
//     return _preferences?.getString(_refreshTokenKey);
//   }

//   static Future<void> saveSessionId(String sessionId) async {
//     await _preferences?.setString(_sessionIdKey, sessionId);
//     debugPrint('Saved session ID: $sessionId');
//   }

//   static String? getSessionId() {
//     return _preferences?.getString(_sessionIdKey);
//   }

//   static Future<void> saveUserId(String userId) async {
//     await _preferences?.setString(_userIdKey, userId);
//     debugPrint('Saved userId: $userId');
//   }

//   static String? getUserId() {
//     return _preferences?.getString(_userIdKey);
//   }

//   static Future<void> saveFirstName(String firstName) async {
//     await _preferences?.setString(_firstNameKey, firstName);
//   }

//   static String? getFirstName() {
//     return _preferences?.getString(_firstNameKey);
//   }

//   static Future<void> saveLastName(String lastName) async {
//     await _preferences?.setString(_lastNameKey, lastName);
//   }

//   static String? getLastName() {
//     return _preferences?.getString(_lastNameKey);
//   }

//   static Future<void> saveEmail(String email) async {
//     await _preferences?.setString(_emailKey, email);
//   }

//   static String? getEmail() {
//     return _preferences?.getString(_emailKey);
//   }

//   static Future<void> savePhoneNumber(String phoneNumber) async {
//     await _preferences?.setString(_phoneNumberKey, phoneNumber);
//   }

//   static String? getPhoneNumber() {
//     return _preferences?.getString(_phoneNumberKey);
//   }

//   static Future<void> savePassword(String password) async {
//     await _preferences?.setString(_passwordKey, password);
//   }

//   static String? getPassword() {
//     return _preferences?.getString(_passwordKey);
//   }

//   static Future<void> saveProvider(String provider) async {
//     await _preferences?.setString(_provider, provider);
//   }

//   static String? getProvider() {
//     return _preferences?.getString(_provider);
//   }

//   static Future<void> saveFcmToken(String token) async {
//     await _preferences?.setString(_fcmTokenKey, token);
//     debugPrint('✅ FCM Token Saved:\n$token');
//   }

//   static String? getFcmToken() {
//     return _preferences?.getString(_fcmTokenKey);
//   }

//   /// Save full user profile as JSON string
//   static Future<void> saveUserProfile(Map<String, dynamic> profileJson) async {
//     try {
//       final jsonString = json.encode(profileJson);
//       await _preferences?.setString(_userProfileKey, jsonString);
//       debugPrint('Saved user profile to storage');
//     } catch (e) {
//       debugPrint('Error saving profile: $e');
//     }
//   }

//   /// Retrieve user profile from local storage
//   static Map<String, dynamic>? getUserProfile() {
//     try {
//       final jsonString = _preferences?.getString(_userProfileKey);
//       if (jsonString != null && jsonString.isNotEmpty) {
//         return json.decode(jsonString) as Map<String, dynamic>;
//       }
//     } catch (e) {
//       debugPrint('Error loading profile: $e');
//     }
//     return null;
//   }

//   /// Clear cached user profile
//   static Future<void> clearUserProfile() async {
//     await _preferences?.remove(_userProfileKey);
//     debugPrint('Cleared user profile from storage');
//   }

//   /// Update a single field in the cached profile
//   static Future<void> updateProfileField(String key, dynamic value) async {
//     try {
//       final profile = getUserProfile() ?? {};
//       profile[key] = value;
//       await saveUserProfile(profile);
//     } catch (e) {
//       debugPrint('Error updating profile field: $e');
//     }
//   }

//   static Future<void> clearAllUserData() async {
//     debugPrint('🧹 Clearing all user data...');
//     await _preferences?.remove(_firstNameKey);
//     await _preferences?.remove(_lastNameKey);
//     await _preferences?.remove(_emailKey);
//     await _preferences?.remove(_phoneNumberKey);
//     await _preferences?.remove(_tokenKey);
//     await _preferences?.remove(_refreshTokenKey);
//     await _preferences?.remove(_sessionIdKey);
//     // ⚠️ DO NOT REMOVE _seenOnboardingKey - users should not see onboarding again after logout
//     await _preferences?.remove(_userIdKey);
//     await _preferences?.remove(_passwordKey);
//     await _preferences?.remove(_provider);
//     await _preferences?.remove(_fcmTokenKey);
//     await _preferences?.remove(_userProfileKey);
//     await _preferences?.remove(_chatRoomIdKey);
//     await _preferences?.remove(_healthContextCacheKey);
//     await _preferences?.remove(_healthContextTimestampKey);
//     await makeLoggedOut();
//     debugPrint('Cleared user data from storage');
//   }

//   // ==================== Chat Room ID Methods ====================

//   /// Generate and save a unique room ID for the chat session
//   static Future<String> generateAndSaveRoomId() async {
//     final roomId = '${DateTime.now().millisecondsSinceEpoch}_${getUserId()}';
//     await _preferences?.setString(_chatRoomIdKey, roomId);
//     debugPrint('Generated new room ID: $roomId');
//     return roomId;
//   }

//   /// Get current room ID or generate new one if not exists
//   static Future<String> getRoomId() async {
//     String? roomId = _preferences?.getString(_chatRoomIdKey);
//     if (roomId == null || roomId.isEmpty) {
//       roomId = await generateAndSaveRoomId();
//     }
//     return roomId;
//   }

//   /// Clear current room ID (useful when starting a new chat)
//   static Future<void> clearRoomId() async {
//     await _preferences?.remove(_chatRoomIdKey);
//     debugPrint('Cleared room ID');
//   }

//   // ==================== Health Context Cache Methods ====================

//   /// Save health context data with timestamp
//   static Future<void> saveHealthContext(Map<String, dynamic> healthData) async {
//     try {
//       final jsonString = json.encode(healthData);
//       await _preferences?.setString(_healthContextCacheKey, jsonString);
//       await _preferences?.setInt(
//         _healthContextTimestampKey,
//         DateTime.now().millisecondsSinceEpoch,
//       );
//       debugPrint('Saved health context to cache');
//     } catch (e) {
//       debugPrint('Error saving health context: $e');
//     }
//   }

//   /// Get cached health context data
//   static Map<String, dynamic>? getHealthContext() {
//     try {
//       final jsonString = _preferences?.getString(_healthContextCacheKey);
//       if (jsonString != null && jsonString.isNotEmpty) {
//         return json.decode(jsonString) as Map<String, dynamic>;
//       }
//     } catch (e) {
//       debugPrint('Error loading health context: $e');
//     }
//     return null;
//   }

//   /// Check if health context cache is still valid (not expired)
//   /// Default expiry: 24 hours
//   static bool isHealthContextValid({int expiryHours = 24}) {
//     try {
//       final timestamp = _preferences?.getInt(_healthContextTimestampKey);
//       if (timestamp == null) return false;

//       final cacheDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
//       final now = DateTime.now();
//       final difference = now.difference(cacheDate);

//       return difference.inHours < expiryHours;
//     } catch (e) {
//       debugPrint('Error checking health context validity: $e');
//       return false;
//     }
//   }

//   /// Clear health context cache
//   static Future<void> clearHealthContext() async {
//     await _preferences?.remove(_healthContextCacheKey);
//     await _preferences?.remove(_healthContextTimestampKey);
//     debugPrint('Cleared health context cache');
//   }
// }

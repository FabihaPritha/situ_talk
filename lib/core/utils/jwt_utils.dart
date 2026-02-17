import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

/// Utility class for handling JWT token operations
class JwtUtils {
  /// Check if a JWT token is expired
  /// Returns true if expired, false if still valid
  static bool isTokenExpired(String token) {
    try {
      return JwtDecoder.isExpired(token);
    } catch (e) {
      debugPrint('❌ Error checking token expiry: $e');
      return true; // Assume expired if we can't decode
    }
  }

  /// Get remaining seconds until token expires
  /// Returns 0 if already expired, -1 if invalid
  static int getSecondsUntilExpiry(String token) {
    try {
      if (JwtDecoder.isExpired(token)) {
        return 0;
      }

      final decodedToken = JwtDecoder.decode(token);
      final exp = decodedToken['exp'] as int?;

      if (exp == null) return -1;

      final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      final now = DateTime.now();
      final difference = expiryDate.difference(now);

      return difference.inSeconds > 0 ? difference.inSeconds : 0;
    } catch (e) {
      debugPrint('❌ Error getting token expiry time: $e');
      return -1;
    }
  }

  /// Check if token is expiring soon (within threshold seconds)
  /// Useful for proactive refresh logic
  static bool isExpiringSoon(String token, {int thresholdSeconds = 60}) {
    final secondsLeft = getSecondsUntilExpiry(token);
    if (secondsLeft == -1) return true; // Invalid token
    return secondsLeft <= thresholdSeconds;
  }

  /// Decode JWT token and return payload
  static Map<String, dynamic>? decodeToken(String token) {
    try {
      return JwtDecoder.decode(token);
    } catch (e) {
      debugPrint('❌ Error decoding token: $e');
      return null;
    }
  }

  /// Get token expiry date
  static DateTime? getExpiryDate(String token) {
    try {
      final decoded = JwtDecoder.decode(token);
      final exp = decoded['exp'] as int?;
      if (exp == null) return null;
      return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    } catch (e) {
      debugPrint('❌ Error getting token expiry date: $e');
      return null;
    }
  }
}

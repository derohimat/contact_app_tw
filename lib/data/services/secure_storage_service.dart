import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  // Save logged-in user ID
  static Future<void> setLoggedInUserId(String userId) async {
    await _storage.write(key: 'loggedInUserId', value: userId);
  }

  // Get logged-in user ID
  static Future<String?> getLoggedInUserId() async {
    return await _storage.read(key: 'loggedInUserId');
  }

  // Clear logged-in user ID (for logout)
  static Future<void> clearLoggedInUserId() async {
    await _storage.delete(key: 'loggedInUserId');
  }
}

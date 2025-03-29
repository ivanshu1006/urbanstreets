
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/logger_service.dart';

class Utils {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future<bool> checkAuthentication() async {
    try {
      final token = await _secureStorage.read(key: 'token');
      logger.info('Checking authentication - Token: $token');
      if (token != null && token.isNotEmpty) {
        log("authenticaton is true");
        return true;
      }
      return false;
    } catch (e) {
      logger.error('Error checking authentication: ${e.toString()}');
      return false;
    }
  }
}

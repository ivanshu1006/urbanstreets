import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Utils {
  static Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static Future<String?> getSid() {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    return secureStorage.read(key: 'sid');
  }
}

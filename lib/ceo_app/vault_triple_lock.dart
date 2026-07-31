// V28 FINAL - VAULT TRIPLE LOCK - IKAW LANG MAKAKA OPEN
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VaultTripleLock {
  static const _storage = FlutterSecureStorage();
  static const _auth = LocalAuthentication();
  static const CEO_EMAIL = 'racazabrent47@gmail.com';

  static Future<bool> canOpenVault() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    if (user.email != CEO_EMAIL) return false;
    final deviceId = await _getDeviceId();
    final savedDeviceId = await _storage.read(key: 'vault_device_id');
    if (savedDeviceId != null && savedDeviceId != deviceId) return false;
    return true;
  }
  static Future<void> setupVault(String pin) async {
    final deviceId = await _getDeviceId();
    await _storage.write(key: 'vault_device_id', value: deviceId);
    await _storage.write(key: 'vault_pin', value: pin);
  }
  static Future<bool> openVault(String pin) async {
    final savedPin = await _storage.read(key: 'vault_pin');
    if (savedPin != pin) return false;
    final canBio = await _auth.canCheckBiometrics;
    if (canBio) {
      final didAuth = await _auth.authenticate(localizedReason: 'Open CEO Vault - Brent Only');
      if (!didAuth) return false;
    }
    return true;
  }
  static Future<String> _getDeviceId() async {
    final info = DeviceInfoPlugin();
    final android = await info.androidInfo;
    return android.id;
  }
}

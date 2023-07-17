library eighty_three_component;

import 'dart:developer';

import 'package:eighty_three_native_component/core/res/src/configuration/top_level_configuration.dart';
import 'package:eighty_three_native_component/core/res/src/constant/shared_orefrences_keys.dart';
import 'package:eighty_three_native_component/core/res/src/permissions/guest_permission.dart';
import 'package:eighty_three_native_component/core/res/src/permissions/permission.dart';
import 'package:eighty_three_native_component/core/res/src/services/security.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  late SharedPreferences _sharedPreferences;
  final FlutterSecureStorage _secureStorage;

  LocalStorageService(this._secureStorage);

  Future<LocalStorageService> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  Future<void> toggleServer() async {
    await writeKey('server', !userOldServer);
    userOldServer = !userOldServer;
  }

  // T readKey<T>(String key, {T? defaultValue}) {
  //   final dynamic value = _sharedPreferences.get(key);

  //   return (value ?? defaultValue) as T;
  // }

  String readString(String key, {String defaultValue = ""}) {
    return _sharedPreferences.getString(key) ?? defaultValue;
  }

  bool readBool(String key, {bool defaultValue = false}) {
    return _sharedPreferences.getBool(key) ?? defaultValue;
  }

  Future<void> writeKey(String key, dynamic value) async {
    if (value.runtimeType.toString().toLowerCase() == 'bool') {
      await _sharedPreferences.setBool(key, value as bool);
    } else {
      await _sharedPreferences.setString(key, value as String);
    }
  }

  Future<void> writeSecureKey(String key, String value) async {
    try {
      if (<String>['null', ''].contains(value)) {
        throw '$key is empty';
      }

      String encryptedKey = encryption(key);
      String encryptedValue = encryption(value);

      await _secureStorage.write(key: encryptedKey, value: encryptedValue);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> removeSession() async {
    await removeAllSecureKeys();
    await removeAllKeysInSharedPreferencesExceptLanguage();

    currentUserPermission = GuestPermission();
    writeKey('install', true);
  }

  Future<String?> readSecureKey(String key, {String? defaultValue}) async {
    String encryptedKey = encryption(key);

    String? value =
        (await _secureStorage.read(key: encryptedKey)) ?? defaultValue;

    return decryption(value ?? "");
  }

  Future<void> removeKey(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> removeAllSecureKeys() async {
    String pinCode = await getUserPinCode ?? "";
    bool faceId = getUserFaceId;
    bool touchId = getUserTouchId;

    await _secureStorage.deleteAll();

    await writeSecureKey('pin_code', pinCode);
    await setFaceIdValue(faceId: faceId);
    await setTouchIdValue(touchId: touchId);
  }

  Future<void> removeAllKeysInSharedPreferencesExceptLanguage() async {
    final String language = readString('lang');
    (await SharedPreferences.getInstance()).clear();
    await writeKey('lang', language);
  }

  ///contain key
  Future<bool> containKey(String key) async {
    return (await SharedPreferences.getInstance()).containsKey(key);
  }

  Future<bool> containSecureKey(String key) async {
    final bool contain = await _secureStorage.containsKey(key: key);
    return contain;
  }

  /// setters and getters
  ///-----setters
  Future<void> setUserToken(String token) async {
    await writeSecureKey('token', token);
    currentUserPermission.token = token;
  }

  Future<void> setUserUUID(String uuid) async {
    await writeSecureKey('uuid', uuid);
    currentUserPermission.userId = uuid;
  }

  Future<void> setUserPhone(String phone) async {
    await writeSecureKey('phone_number', phone);
    currentUserPermission.phone = phone;
  }

  Future<void> setUserPinCode(String pinCode) async {
    if (pinCode.isNotEmpty) {
      String hashed = getHashedCode(pinCode);
      await writeSecureKey('pin_code', hashed);
      currentUserPermission.pinCode = hashed;
    }
  }

  Future<void> setTouchIdValue({required bool touchId}) async {
    await writeKey('touch_id_active', touchId);
    currentUserPermission.isTouchIdActive = touchId;
  }

  Future<void> setUsername(String name) async {
    await writeSecureKey('name', name);
    currentUserPermission.name = name;
  }

  Future<void> setFullName(String name) async {
    await writeKey('full_name', name);
    currentUserPermission.name = name;
  }

  Future<void> setFaceIdValue({required bool faceId}) async {
    await writeKey('face_id_active', faceId);
    currentUserPermission.isFaceIdActive = faceId;
  }

  Future<void> setUserCountry({required String country}) async {
    await writeSecureKey('country', country);
    currentUserPermission.country = country;
  }

  Future<void> setUserCurrency({required String currency}) async {
    await writeSecureKey('currency', currency);
    currentUserPermission.currency = currency;
  }

  Future<void> setUserId(String id) async {
    await writeSecureKey('identity_id', id);
    currentUserPermission.identityId = id;
  }

  Future<void> setAppInstalled() async {
    await writeKey('install', true);
  }

  Future<void> setLanguage(String locale) async {
    await writeKey('lang', locale);
  }

  Future<void> setUserRole(String roleValue) async {
    await writeSecureKey('role', roleValue);
  }

  Future<void> setUserEmail(String emailValue) async {
    await writeSecureKey('email', emailValue);
  }

  Future<void> setProfileCompleted(bool completed) async {
    await writeKey('is_completed', completed);
  }

  ///---- getters
  Future<String?> get getUserToken async {
    final token = await readSecureKey('token');
    return token;
  }

  // String userToken = 'token';
// String userName = 'name';
// String fullName = 'full_name';
// String userCountry = 'country';
// String serverKey = 'server';
// String cameraPermission = 'camera_permission';
// String galleryPermission = 'gallery_permission';
//
// String userCurrency = 'currency';
// String userId = 'identity_id';
// String userDate = 'dob';
// String userPinCode = 'pin_code';
// String userTouchId = 'touch_id_active';
// String userFaceId = 'face_id_active';
// String userUUID = 'uuid';
// String userPhone = 'phone_number';
// String userEmail = 'email';
// String appInstalled = 'install';
// String role = 'role';
// String profileCompleted = 'is_completed';
  Future<String?> get getUserCountry => readSecureKey('country');

  Future<String?> get getUserCurrency => readSecureKey('currency');

  Future<String?> get getUserUUID => readSecureKey('uuid');

  Future<String?> get getUserPhone => readSecureKey('phone_number');

  Future<String?> get getUserPinCode => readSecureKey('pin_code');

  Future<String?> get getUserId => readSecureKey('identity_id');

  Future<String?> get getUserEmail => readSecureKey('email');

  bool get getUserTouchId => readBool('touch_id_active');

  bool get getUserFaceId => readBool('face_id_active');

  String? get getUserName => readString('name');

  String? get getUserLanguage => readString('lang');

  bool get getIsProfileCompleted => readBool('is_completed');

  Future<String?> get getUserRole => readSecureKey('role');

  bool get isAppInstalled => readBool('install');

  String? get getFullName => readString('full_name');

  Future<void> cacheCurrentUser(UserPermission user) async {
    await setUserId(user.identityId.toString());
    await setUsername(user.name.toString());
    await setUserToken(user.token.toString());
    await setUserUUID(user.userId.toString());
    await setUserPhone(user.phone.toString());
    //await setUserPinCode(user.pinCode.toString());
    await setUserCountry(country: user.country.toString());
    await setUserCurrency(currency: user.currency.toString());
    //await setTouchIdValue(touchId: user.isTouchIdActive ?? false);
    //await setFaceIdValue(faceId: user.isFaceIdActive ?? false);
  }
}

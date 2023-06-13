library eighty_three_component;

import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
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
    await writeKey(serverKey, !userOldServer);
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
      await _secureStorage.write(key: key, value: value);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> removeSession() async {
    await removeAllSecureKeys();
    await removeAllKeysInSharedPreferencesExceptLanguage();

    currentUserPermission = GuestPermission();
    writeKey(appInstalled, true);
  }

  Future<String?> readSecureKey(String key, {String? defaultValue}) async {
    return await _secureStorage.read(key: key) ?? defaultValue;
  }

  Future<void> removeKey(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> removeAllSecureKeys() async {
    String pinCode = await getUserPinCode ?? "";
    bool faceId = getUserFaceId;
    bool touchId = getUserTouchId;

    await _secureStorage.deleteAll();

    await writeSecureKey(userPinCode, pinCode);
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
    await writeSecureKey(userToken, token);
    currentUserPermission.token = token;

    print(
        'currentUserPermission.token = token = ${currentUserPermission.token}');
  }

  Future<void> setUserUUID(String uuid) async {
    await writeSecureKey(userUUID, uuid);
    currentUserPermission.userId = uuid;
  }

  Future<void> setUserPhone(String phone) async {
    await writeSecureKey(userPhone, phone);
    currentUserPermission.phone = phone;
  }

  Future<void> setUserPinCode(String pinCode) async {
    if (pinCode.isNotEmpty) {
      String hashed = getHashedCode(pinCode);
      await writeSecureKey(userPinCode, hashed);
      currentUserPermission.pinCode = hashed;
    }
  }

  Future<void> setTouchIdValue({required bool touchId}) async {
    await writeKey(userTouchId, touchId);
    currentUserPermission.isTouchIdActive = touchId;
  }

  Future<void> setUsername(String name) async {
    await writeKey(userName, name);
    currentUserPermission.name = name;
  }

  Future<void> setFullName(String name) async {
    await writeKey(fullName, name);
    currentUserPermission.name = name;
  }

  Future<void> setFaceIdValue({required bool faceId}) async {
    await writeKey(userFaceId, faceId);
    currentUserPermission.isFaceIdActive = faceId;
  }

  Future<void> setUserCountry({required String country}) async {
    await writeSecureKey(userCountry, country);
    currentUserPermission.country = country;
  }

  Future<void> setUserCurrency({required String currency}) async {
    await writeSecureKey(userCurrency, currency);
    currentUserPermission.currency = currency;
  }

  Future<void> setUserId(String id) async {
    await writeSecureKey(userId, id);
    currentUserPermission.identityId = id;
  }

  Future<void> setAppInstalled() async {
    await writeKey(appInstalled, true);
  }

  Future<void> setLanguage(String locale) async {
    await writeKey('lang', locale);
  }

  Future<void> setUserRole(String roleValue) async {
    await writeSecureKey(role, roleValue);
  }

  Future<void> setUserEmail(String emailValue) async {
    await writeSecureKey(userEmail, emailValue);
  }

  Future<void> setProfileCompleted(bool completed) async {
    await writeKey(profileCompleted, completed);
  }

  ///---- getters
  Future<String?> get getUserToken async {
    final token = await readSecureKey(userToken);
    return token;
  }

  Future<String?> get getUserCountry => readSecureKey(userCountry);

  Future<String?> get getUserCurrency => readSecureKey(userCurrency);

  Future<String?> get getUserUUID => readSecureKey(userUUID);

  Future<String?> get getUserPhone => readSecureKey(userPhone);

  Future<String?> get getUserPinCode => readSecureKey(userPinCode);

  Future<String?> get getUserId => readSecureKey(userId);
  Future<String?> get getUserEmail => readSecureKey(userEmail);

  bool get getUserTouchId => readBool(userTouchId);

  bool get getUserFaceId => readBool(userFaceId);

  String? get getUserName => readString(userName);
  String? get getUserLanguage => readString('lang');
  bool get getIsProfileCompleted => readBool(profileCompleted);
  Future<String?> get getUserRole => readSecureKey(role);

  bool get isAppInstalled => readBool(appInstalled);
  String? get getFullName => readString(fullName);

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

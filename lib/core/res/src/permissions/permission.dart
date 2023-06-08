import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:eighty_three_native_component/core/utils/parsing/from_map.dart';
import 'package:eighty_three_native_component/core/utils/parsing/parent_model.dart';

import 'guest_permission.dart';

UserPermission currentUserPermission = GuestPermission();


String getHashedCode(String plainText){
  var bytes1 = utf8.encode(plainText);
  print(sha256.convert(bytes1).toString());
  return sha256.convert(bytes1).toString();
}

class UserPermission extends ParentModel {
  String? token;
  String? name;
  String? userId;
  String? phone;
  String? username;
  String? country;
  String? identityId;
  String? locale;
  String? email;
  String? image;
  bool? isCompleted;

  bool get isLoggedIn => token != null;

  bool? isSetFaceId;
  bool? isSetTouchId;
  String? currency;
  bool? isTouchIdActive;
  bool? isFaceIdActive;
  String? pinCode;

  UserPermission({
    this.name,
    this.phone,
    this.country,
    this.userId,
    this.isSetFaceId,
    this.isSetTouchId,
    this.identityId,
    this.email,
    this.locale,
    this.token,
    this.pinCode,
    this.image,
    this.isCompleted,
    this.currency,
    this.isFaceIdActive,
    this.isTouchIdActive,
    this.username,
  });

  bool comparePinCode(String code){
    return getHashedCode(code) == pinCode;
  }

  bool get isArabic => locale == 'ar';

  bool get isUsingLocalAuth =>
      pinCode != null || isSetFaceId == true || isSetTouchId == true;

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter =
        FromMap(map: json['user'] as Map<String, dynamic>);
    return UserPermission(
      country: getCountryCode(json, converter),
      token: converter.convertToString(key: 'token'),
      locale: json["user"]['locale'] != null
          ? converter.convertToString(key: "locale")
          : converter.convertToString(key: "language"),
      email: converter.convertToString(key: 'email'),
      userId: json["id"] != null
          ? converter.convertToString(key: 'id')
          : converter.convertToString(key: 'uuid'),
      name: converter.convertToString(key: 'full_name'),
      identityId: converter.convertToString(
          key: 'identity', defaultValue: json["identity_id"].toString()),
      phone: converter.convertToString(key: "phone_number"),
      isCompleted: converter.convertToBool(key: 'is_completed') ?? false,
      //isSetFaceId: converter.convertToBool(key: "face_id_activated"),
      //isSetTouchId: converter.convertToBool(key: "touch_id_activated"),
      //isFaceIdActive: converter.convertToBool(key: "is_active", defaultValue: false),
      //isTouchIdActive: converter.convertToBool(key: "touch_id_active", defaultValue: false),
      currency: converter.convertToString(key: "currency", defaultValue: ""),
    );
  }

  String? getCountryCode(Map<String, dynamic> json, FromMap converter) {
    if (json["user"]["country"] is Map<String, dynamic>) {
      return converter.convertToString(
          key: 'code',
          innerMap: (json['user'] as Map<String, dynamic>)['country']
              as Map<String, dynamic>);
    } else {
      return converter.convertToString(key: "country");
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "id": userId ?? "0",
      "token": token ?? "",
      "name": name ?? "",
      "username": username ?? "",
      "phone": phone ?? "",
      "country": country ?? "",
      "identity_id": identityId ?? "",
      "email": email ?? "",
      "locale": locale ?? "",
      "image": image ?? "",
    };
  }
}

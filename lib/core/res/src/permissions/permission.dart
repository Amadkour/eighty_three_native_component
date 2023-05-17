import 'package:eighty_three_native_component/core/utils/parsing/from_map.dart';
import 'package:eighty_three_native_component/core/utils/parsing/parent_model.dart';

import 'guest_permission.dart';

enum RoleName { guest, parent, child }

UserPermission currentUserPermission = GuestPermission();

class UserPermission extends ParentModel {
  RoleName role = RoleName.parent;
  String? token;
  String? name;
  String? userId;
  String? language;
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
    this.language,
    this.username,
    this.role = RoleName.guest,
  });


  bool get isArabic => locale == 'ar';

  bool get isUsingLocalAuth =>
      pinCode != null || isSetFaceId == true || isSetTouchId == true;

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter =
    FromMap(map: json['user'] as Map<String, dynamic>);
    // role = ((json['user'] as Map<String, dynamic>)['is_parent'] as bool)
    //     ? RoleName.parent
    //     : RoleName.child;

    return UserPermission(
      country: converter.convertToString(
          key: 'code',
          innerMap: (json['user'] as Map<String, dynamic>)['country']
          as Map<String, dynamic>),
      // role: ((json['user'] as Map<String, dynamic>)['is_parent'] as bool)
      //     ? RoleName.parent
      //     : RoleName.child,
      token: converter.convertToString(key: 'token'),
      locale: converter.convertToString(key: "language"),
      email: converter.convertToString(key: 'email'),
      userId:
      converter.convertToString(key: 'id', defaultValue: json['user_uuid']),
      name: converter.convertToString(key: 'full_name'),
      identityId: converter.convertToString(
          key: 'identity', defaultValue: json["identity_id"].toString()),
      phone: converter.convertToString(key: "phone_number"),
      isCompleted: converter.convertToBool(key: 'is_completed') ?? false,
      isSetFaceId: converter.convertToBool(key: "face_id_activated"),
      isSetTouchId: converter.convertToBool(key: "touch_id_activated"),
      pinCode: converter.convertToString(key: "pincode"),
      isFaceIdActive:
      converter.convertToBool(key: "is_active", defaultValue: false),
      isTouchIdActive:
      converter.convertToBool(key: "touch_id_active", defaultValue: false),
      currency: converter.convertToString(key: "currency", defaultValue: ""),
    );
  }
}


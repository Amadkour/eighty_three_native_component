import 'package:eighty_three_component/core/utils/parsing/from_map.dart';
import 'package:eighty_three_component/core/utils/parsing/parent_model.dart';
import 'package:res/modules/authentication/permissions/guest_permission.dart';

enum RoleName { guest, parent, child }

UserPermission currentUserPermission = GuestPermission();

class UserPermission extends ParentModel {
  late RoleName role;
  String? token;
  String? name;
  String? language;
  String? phone;
  String? username;
  String? country;
  String? email;
  bool isCompleted = false;

  bool get isLoggedIn => token != null;

  bool? isSetFaceId;
  bool? isSetTouchId;
  String? pinCode;

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter =
        FromMap(map: json['user'] as Map<String, dynamic>);
    role = ((json['user'] as Map<String, dynamic>)['is_parent'] as bool)
        ? RoleName.parent
        : RoleName.child;

    token = converter.convertToString(key: 'token');

    language = converter.convertToString(key: "language");
    phone = converter.convertToString(key: "phone_number");
    email = converter.convertToString(key: 'email');
    name = converter.convertToString(key: 'full_name');
    username = converter.convertToString(key: 'username');
    country = converter.convertToString(
        key: 'code',
        innerMap: (json['user'] as Map<String, dynamic>)['country']
            as Map<String, dynamic>);

    isCompleted = converter.convertToBool(key: 'is_completed') ?? false;
    isSetFaceId = converter.convertToBool(key: "face_id_activated");
    isSetTouchId = converter.convertToBool(key: "touch_id_activated");
    pinCode = converter.convertToString(key: "pincode");

    return this;
  }
}

import 'package:eighty_three_native_component/core/res/src/permissions/permission.dart';

class GuestPermission extends UserPermission {
  GuestPermission() {
    role = RoleName.guest;
    token = null;
  }
}

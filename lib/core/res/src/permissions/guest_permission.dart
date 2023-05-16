import 'package:res/modules/authentication/permissions/permission.dart';

class GuestPermission extends UserPermission {
  GuestPermission() {
    role = RoleName.guest;
    token = null;
  }
}

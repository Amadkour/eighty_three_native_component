import 'package:res/modules/authentication/permissions/permission.dart';

class ChildPermission extends UserPermission {
  ChildPermission() {
    role = RoleName.child;
  }
}

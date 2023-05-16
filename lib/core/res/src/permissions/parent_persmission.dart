import 'package:res/modules/authentication/permissions/permission.dart';

class ParentPermission extends UserPermission {
  ParentPermission() {
    role = RoleName.parent;
  }
}

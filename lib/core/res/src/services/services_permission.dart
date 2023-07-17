import 'package:eighty_three_native_component/core/res/src/configuration/top_level_configuration.dart';
import 'package:eighty_three_native_component/core/res/src/constant/shared_orefrences_keys.dart';
import 'package:eighty_three_native_component/core/res/src/services/dependency_jnjection.dart';
import 'package:eighty_three_native_component/core/res/src/services/local_storage_service.dart';
import 'package:eighty_three_native_component/core/res/src/widget/dialogs/go_to_native_settings_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ServicesPermissions {

  Future<XFile?> cameraAndGalleryRequestPermission({
    required Permission permission,
    required ImageSource source,
    required bool isAlreadyOpened,
    required String subTitle
  }) async {
    if(isAlreadyOpened){
      PermissionStatus status = await permission.status;
      if (![PermissionStatus.denied ,PermissionStatus.permanentlyDenied,PermissionStatus.restricted].contains(status)) {
        return await ImagePicker().pickImage(
          source: source,
          maxHeight: 1000,
          maxWidth: 1000,
        );
      }
      else{
        showPermissionDialog(subTitle: subTitle);
      }
    }
    else{
      if(source == ImageSource.camera){
        cameraPermissionIsAlreadyOpened = true;
        sl<LocalStorageService>().writeKey('camera_permission', cameraPermissionIsAlreadyOpened);
      }
      else{
        galleryPermissionIsAlreadyOpened = true;
        sl<LocalStorageService>().writeKey('gallery_permission', galleryPermissionIsAlreadyOpened);
      }
      PermissionStatus status = await permission.request();
      if (status.isGranted) {
        return await ImagePicker().pickImage(
          source: source,
          maxHeight: 1000,
          maxWidth: 1000,
        );
      }
    }
    return null;
  }

  void showPermissionDialog({required String subTitle}){
    GoToNativeSettingsDialog.dialog(globalKey.currentContext!, subTitle);
  }
}


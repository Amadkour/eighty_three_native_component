import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:eighty_three_native_component/core/res/src/constant/shared_orefrences_keys.dart';
import 'package:eighty_three_native_component/core/res/src/cubit/global_cubit.dart';
import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/src/widget/button/loading_button.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ServicesPermissions {

  Future<XFile?> cameraAndGalleryRequestPermission(
      {required Permission permission,
      required ImageSource source,
      required String title,
      required String subTitle}) async {
    PermissionStatus status = await permission.status;
    if (status.isGranted) {
      return await ImagePicker().pickImage(
        source: source,
        maxHeight: 1000,
        maxWidth: 1000,
      );
    } else if (status.isDenied || status.isPermanentlyDenied) {
      final PermissionStatus permissionStatus = await permission.request();
      if(permissionStatus==PermissionStatus.granted){
        return await ImagePicker().pickImage(
          source: source,
          maxHeight: 1000,
          maxWidth: 1000,
        );
      }
      else{
        showDialog(
          context: globalKey.currentContext!,
          builder: (BuildContext context) => Directionality(
            textDirection:isArabic ? TextDirection.rtl:TextDirection.ltr,
            child: AlertDialog(
              title: Text(title),
              content: Text(
                subTitle,
              ),
              actions: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: 150,
                  height: 50,
                  child: LoadingButton(
                    hasBottomSaveArea: false,
                    topPadding: 0,
                    onTap: () async {
                      CustomNavigator.instance.pop();
                      await AppSettings.openAppSettings();
                      await openAppSettings();
                    },
                    title: tr("open_settings"),
                    isLoading: false,
                  ),
                )
              ],
            ),
          ),
        );
      }
    }
    return null;
  }
}

import 'package:eighty_three_native_component/core/utils/parsing/from_map.dart';
import 'package:eighty_three_native_component/core/utils/parsing/parent_model.dart';

class Notification extends ParentModel {
  String? uuid;
  String? message;
  String? icon;
  DateTime? readAt;
  String? service;
  bool? canDelete;
  bool? isRead;

  Notification({this.uuid, this.message, this.icon, this.readAt, this.service,this.isRead,this.canDelete});

  @override
  Notification fromJsonInstance(Map<String, dynamic> json) {
    final FromMap fromMap = FromMap(map: json);
    return Notification(
      uuid: fromMap.convertToString(key: 'uuid'),
      message: fromMap.convertToString(key: 'message'),
      icon: fromMap.convertToString(key: 'icon'),
      readAt: fromMap.convertToDateTime(key: 'read_at'),
      service: fromMap.convertToString(key: 'service'),
      isRead: fromMap.convertToBool(key: 'is_read'),
      canDelete: fromMap.convertToBool(key: 'can_delete'),
    );
  }
}

class NotificationModel extends ParentModel {
  List<Notification>? notifications;
  NotificationModel({this.notifications});
  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    return NotificationModel(
        notifications: (json['notifications'] as List<dynamic>)
            .map((e) => Notification().fromJsonInstance(e))
            .toList());
  }
}

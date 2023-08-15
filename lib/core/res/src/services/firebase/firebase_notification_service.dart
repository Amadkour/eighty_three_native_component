import 'dart:developer';
import 'package:eighty_three_native_component/core/res/src/configuration/top_level_configuration.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotificationsService {
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin;
  String packageName;
  String appName;
  FirebaseNotificationsService(
      this._localNotificationsPlugin,  this.packageName, this.appName);

  Future<void> initNotificationService() async {
    await FirebaseMessaging.instance.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
    );

    getDeviceToken().then((String value) {
      if (type == 'test') {
        log('device_token:$value');
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await sendLocalMessage(message, message.data['payload'] as String?);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      final String? json = event.data['payload'] as String?;
      _mapPayload(json);
    });

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings(
        "app_logo",
      ),
      iOS: DarwinInitializationSettings(),
    );
    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {},
    );
  }

  void _mapPayload(String? payload) {}
 int _hashCode=0;
  Future<void> sendLocalMessage(
      RemoteMessage? notification, String? payload) async {
    if(_hashCode!= notification.hashCode) {
      _hashCode=notification.hashCode;
      await _localNotificationsPlugin.show(
        notification.hashCode,
        notification?.notification?.title ??
            notification?.data['title'] as String?,
        notification?.notification?.body ?? notification?.data['body'] as String?,
        NotificationDetails(
          android: AndroidNotificationDetails(
            packageName,
            appName,
            icon: 'app_logo',
          ),
        ),
        payload: payload,
      );
    }
  }

  Future<String> getDeviceToken() async {
    return (await FirebaseMessaging.instance.getToken()) ?? "";
  }
}

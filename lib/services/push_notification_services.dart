import 'dart:convert';

import 'package:auth_api/config/router/app_route.dart';
import 'package:auth_api/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async{
  print("Title: ${message.notification?.title}");
  print("Body: ${message.notification?.body}");
  print("Payload: ${message.data}");
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  
  void handleMessage(RemoteMessage? message) {
    if (message == null) return ;
    navigatorKey.currentState?.pushNamed(AppRoutes.NOTIFICATIONS, arguments: message);
  }

  Future initPushNotifications() async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then((handleMessage));
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification != null) {
        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: "@drawable/ic_launcher",
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
      }
    });
  }

  final _androidChannel = const AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.', // description
  importance: Importance.defaultImportance,
  );
  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future initLocalNotifications() async{
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings("@drawable/ic_launcher");
    const settings = InitializationSettings(android: android, iOS: iOS);

    await _localNotifications.initialize(
        settings,
        onDidReceiveBackgroundNotificationResponse: (payload) {
          final message = RemoteMessage.fromMap(jsonDecode(payload!.toString()));
          handleMessage(message);
        }
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> initNotifications() async{
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print("Token: $fcmToken");
    initPushNotifications();
    initLocalNotifications();
  }
}
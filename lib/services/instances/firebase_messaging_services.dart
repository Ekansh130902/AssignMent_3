
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:test3/main.dart';

class FirebaseMessagingServices{
  final _firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> handleBackgroundMessage(RemoteMessage message) async{
    print("Title: ${message.notification?.title ?? "No Title"}");
    print("Body: ${message.notification?.body ?? "No Body"}");
    print("Data: ${message.data}");
  }

  Future<void> handleMessage(RemoteMessage? message) async{
    if(message == null) return;

    // navigatorKey.currentState?.pushNamed(
    //     // NotificationScreen.route,
    //     arguments: message
    // );
  }

  Future initPushNotifications() async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<String?> initNotifications() async{
    await _firebaseMessaging.requestPermission();
    final String? fcmToken = await _firebaseMessaging.getToken();
    return fcmToken;
  }
}
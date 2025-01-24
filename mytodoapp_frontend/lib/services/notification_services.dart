import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mytodoapp_frontend/models/notification.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationServices {
  List<NotificationModel> allNotifications = [];

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> requestPermissions() async {
    PermissionStatus permissionStatus = await Permission.notification.request();

    if (permissionStatus != PermissionStatus.granted) {
      throw ('No Access to Notifications');
    }
  }

  showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel_Id',
      'channel Name',
      channelDescription: 'Channel Discription',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    int notificationID = 1;

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      notificationID,
      message.notification!.title,
      message.notification!.body,
      notificationDetails,
      payload: 'Not Present',
    );
  }

  Future<void> saveNotificationFirebase(String? title, String? body) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection("Notifications")
          .doc()
          .set({
        'title': title,
        'body': body,
        'isRead': false,
      });
    } catch (e) {
      print('Notification Store Error: $e');
    }
  }

  Future<void> getAllNotifications() async {
    allNotifications.clear();

    QuerySnapshot notificationSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Notifications")
        .get();

    for (var notification in notificationSnapshot.docs) {
      NotificationModel notificationModel = NotificationModel(
        title: notification['title'],
        body: notification['body'],
        isRead: notification['isRead'],
        id: notification.id.toString(),
      );

      allNotifications.add(notificationModel);
    }
  }
}

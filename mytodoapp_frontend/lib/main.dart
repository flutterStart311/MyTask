import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mytodoapp_frontend/firebase_options.dart';
import 'package:mytodoapp_frontend/services/notification_services.dart';
import 'package:mytodoapp_frontend/splash_screen.dart';

Future _handleBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print('Available Background Notification');
  }
}

String? token = '';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  NotificationServices().requestPermissions();
  NotificationServices().initNotifications();

  await FirebaseMessaging.instance.getToken().then((value) {
    print('Notification Token: $value');
    token = value;
  });

  FirebaseMessaging.onMessage.listen((event) async {
    NotificationServices().showNotification(event);
    await NotificationServices().saveNotificationFirebase(
        event.notification!.title, event.notification!.body);
  });

  FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print(message.notification);
    }
  });

  runApp(MyApp(
    notificationToken: token!,
  ));
}

class MyApp extends StatelessWidget {
  final String notificationToken;
  const MyApp({super.key, required this.notificationToken});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My ToDo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(
        fcmToken: notificationToken,
      ),
    );
  }
}

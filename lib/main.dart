import 'dart:developer';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:demo_project/core/router/routes.dart';
import 'package:demo_project/firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  log('Background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationService().init();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: getRoute,
    );
  }
}


class NotificationService {
  final _fcm = FirebaseMessaging.instance;

  Future<void> init() async {
    // 1. permission
    final settings = await _fcm.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.denied) return;

    // 2. token
    final token = await _fcm.getToken();
    log('FCM token: $token');

    // 3. token badle to naya milega
    _fcm.onTokenRefresh.listen((newToken) {
      // yahan backend/Firestore mein update karo
    });

    // 4. app khula (foreground) hai tab message aaye
    FirebaseMessaging.onMessage.listen((message) {
      log('Foreground: ${message.notification?.title}');
      // Get.snackbar(...) ya local notification dikhao
    });

    // 5. notification tap karke background se app khola
    FirebaseMessaging.onMessageOpenedApp.listen(_handleTap);

    // 6. app band tha, notification tap karke khola
    final initial = await _fcm.getInitialMessage();
    if (initial != null) _handleTap(initial);
  }

  void _handleTap(RemoteMessage message) {
    final screen = message.data['screen'];
    // go_router se us screen par jao
  }
}
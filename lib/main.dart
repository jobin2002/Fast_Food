import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/home%20widgets/firstscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAUBigNIq6HFoIQfUvZpl0T-4LnVDu_kFc',
          appId: '1:485196800024:android:fdd64ee38a01cec5bce36d',
          messagingSenderId: '485196800024',
          projectId: 'mainproject-f777c',
          storageBucket: 'mainproject-f777c.appspot.com'));
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_notification',
          channelName: 'Tastees',
          channelDescription: 'notification Settings',
          importance: NotificationImportance.Max,
          playSound: true,
          enableVibration: true,
        )
      ],
      debug: true);
  runApp(const Myapp2());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return const frontscrn();
  }
}

class Myapp2 extends StatelessWidget {
  const Myapp2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Myapp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

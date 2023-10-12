import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application_1_day4/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_handler);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);

  String? token = await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessage.listen((message) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 10,
      channelKey: 'basic_channel',
      actionType: ActionType.Default,
      title: message.data["title"],
      body: message.data["body"],
    ));
  });

  runApp(MyApp());
}

Future<void> _handler(RemoteMessage message) async {
  AwesomeNotifications().createNotification(
      content: NotificationContent(
    id: 10,
    channelKey: 'basic_channel',
    actionType: ActionType.Default,
    title: message.data["title"],
    body: message.data["body"],
  ));
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Notification Messageing"),
        ),
      ),
    );
  }
}


























































// class MyHomePage extends StatelessWidget {
//   final CollectionReference users =
//       FirebaseFirestore.instance.collection('users');

//   Future<void> addUser() {
//     return users
//         .add({
//           'name': 'shahd alrahbi',
//           'email': 'shahd@gmail.com',
//         })
//         .then((value) => print('User Added'))
//         .catchError((error) => print('Failed to add user: $error'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firestor'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           child: Text('Add User to Firestore'),
//           onPressed: addUser,
//         ),
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:ratailapp/App/Screen/LogInPage.dart';
import 'package:ratailapp/App/Screen/NavigationBar.dart';
import 'package:ratailapp/core/access_token.dart';
import 'package:ratailapp/core/notification_services.dart';

import 'package:ratailapp/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationServices().initNotification();


  initializeNotification();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  handleForegroundMessage();

  runApp( MyApp());
}


initializeNotification () async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
}

handleForegroundMessage () {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      NotificationServices().showNotification(
        title: message.notification!.title,
        body: message.notification!.body,
      );


      // Increment badge count
      _incrementBadgeCount();
    }
  });
}


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");

  // Increment badge count on receiving background notification
  _incrementBadgeCount();
}

Future<void> _incrementBadgeCount() async {

  print('I am here');


  SharedPreferences prefs = await SharedPreferences.getInstance();
  int badgeCount = prefs.getInt('badgeCount') ?? 0;
  badgeCount++;
  await prefs.setInt('badgeCount', badgeCount);
  FlutterAppBadger.updateBadgeCount(badgeCount);
}

Future<void> _clearBadgeCount() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('badgeCount', 0);
  FlutterAppBadger.removeBadge(); // Clear the badge count
}


class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _clearBadgeCount(); // Clear badge count when the app is opened
  }


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //git add
      debugShowCheckedModeBanner: false,

      home: user == null ?  LogInSreen() :  MainBottomNavBar(),// HomePage(),
      //home:  FormPage(),
    );
  }
}






// class MyApp extends StatelessWidget {
//   MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Retail App",
//       debugShowCheckedModeBanner: false,
//       color: Colors.blueAccent,
//       theme: ThemeData(primaryColor: Colors.lightBlue),
//       darkTheme: ThemeData(primaryColor: Colors.black54),
//       themeMode: ThemeMode.dark,
//       home: FutureBuilder<User?>(
//         future: FirebaseAuth.instance.authStateChanges().first,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Scaffold(
//               body: Center(
//                 child: CircularProgressIndicator(), // or a splash screen
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Scaffold(
//               body: Center(child: Text('Error: ${snapshot.error}')),
//             );
//           } else {
//             final user = snapshot.data;
//             if (user != null) {
//               if (user.uid == "O2GV6e7kUUN4ZhRTgs4JwvUipg43") {
//                 return AdminMainBottomNavBar();
//               } else {
//                 return MainBottomNavBar();
//               }
//             } else {
//               return LogInSreen();
//             }
//           }
//         },
//       ),
//     );
//   }
// }
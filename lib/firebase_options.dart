// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCoW2ppRGDLal7_hUl_sqiF1p9en7GleiI',
    appId: '1:363953019706:web:bef9845fef4aad91d5ce03',
    messagingSenderId: '363953019706',
    projectId: 'retailappstore',
    authDomain: 'retailappstore.firebaseapp.com',
    storageBucket: 'retailappstore.appspot.com',
    measurementId: 'G-BNRGYYCLY4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBNErI78XK70QhbZnp9HR5ET6IXnDZiO6Q',
    appId: '1:363953019706:android:9cc50a58162d69ddd5ce03',
    messagingSenderId: '363953019706',
    projectId: 'retailappstore',
    storageBucket: 'retailappstore.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBykdqtfdJUdhsglgaFtl-0xBGocHtp5tQ',
    appId: '1:363953019706:ios:d251f24b8bf68b04d5ce03',
    messagingSenderId: '363953019706',
    projectId: 'retailappstore',
    storageBucket: 'retailappstore.appspot.com',
    iosBundleId: 'com.retailapp.name',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCoW2ppRGDLal7_hUl_sqiF1p9en7GleiI',
    appId: '1:363953019706:web:b6655a385c3045eed5ce03',
    messagingSenderId: '363953019706',
    projectId: 'retailappstore',
    authDomain: 'retailappstore.firebaseapp.com',
    storageBucket: 'retailappstore.appspot.com',
    measurementId: 'G-J5JBY73NS9',
  );

}
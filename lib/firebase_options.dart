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
        return macos;
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
    apiKey: 'AIzaSyA14mtnHZYGzaemL44K9pVTId-duiv3kmw',
    appId: '1:390225675033:web:0baabdc6c875c1017cbb88',
    messagingSenderId: '390225675033',
    projectId: 'airgroup-6bdd4',
    authDomain: 'airgroup-6bdd4.firebaseapp.com',
    storageBucket: 'airgroup-6bdd4.appspot.com',
    measurementId: 'G-1W5HX31JGJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBeMudodbtej74A4EHosyy0PiJn-XbcDMI',
    appId: '1:390225675033:android:d1dd73baa53231f37cbb88',
    messagingSenderId: '390225675033',
    projectId: 'airgroup-6bdd4',
    storageBucket: 'airgroup-6bdd4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCmDmi03Yg7DeK2ufkiFXdhnISgr_bonRw',
    appId: '1:390225675033:ios:271ce30dac7288ff7cbb88',
    messagingSenderId: '390225675033',
    projectId: 'airgroup-6bdd4',
    storageBucket: 'airgroup-6bdd4.appspot.com',
    iosBundleId: 'com.example.airsale',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCmDmi03Yg7DeK2ufkiFXdhnISgr_bonRw',
    appId: '1:390225675033:ios:271ce30dac7288ff7cbb88',
    messagingSenderId: '390225675033',
    projectId: 'airgroup-6bdd4',
    storageBucket: 'airgroup-6bdd4.appspot.com',
    iosBundleId: 'com.example.airsale',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA14mtnHZYGzaemL44K9pVTId-duiv3kmw',
    appId: '1:390225675033:web:2ebd6d81ab5d267a7cbb88',
    messagingSenderId: '390225675033',
    projectId: 'airgroup-6bdd4',
    authDomain: 'airgroup-6bdd4.firebaseapp.com',
    storageBucket: 'airgroup-6bdd4.appspot.com',
    measurementId: 'G-ZWKMDKNMQ5',
  );
}

// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAdCgKxqHugK99sMFiVbKjKbqY2YSXeU0Q',
    appId: '1:397476529560:web:06609388a5c13d577d97ed',
    messagingSenderId: '397476529560',
    projectId: 'wawaaaa-59eeb',
    authDomain: 'wawaaaa-59eeb.firebaseapp.com',
    storageBucket: 'wawaaaa-59eeb.appspot.com',
    measurementId: 'G-PS5G536W3E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCIj1OtekOtn_zBtKBwcBMQRdIu6MxOFGc',
    appId: '1:397476529560:android:e0f6d214f65eedd37d97ed',
    messagingSenderId: '397476529560',
    projectId: 'wawaaaa-59eeb',
    storageBucket: 'wawaaaa-59eeb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDoVJ19UNzKnBSCztJ5ke5sg-eObunFtJw',
    appId: '1:397476529560:ios:6bc79050c3488c607d97ed',
    messagingSenderId: '397476529560',
    projectId: 'wawaaaa-59eeb',
    storageBucket: 'wawaaaa-59eeb.appspot.com',
    iosClientId: '397476529560-2r4sckp6flt3c46ocnsi47tarfir8id6.apps.googleusercontent.com',
    iosBundleId: 'com.example.learning',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDoVJ19UNzKnBSCztJ5ke5sg-eObunFtJw',
    appId: '1:397476529560:ios:6bc79050c3488c607d97ed',
    messagingSenderId: '397476529560',
    projectId: 'wawaaaa-59eeb',
    storageBucket: 'wawaaaa-59eeb.appspot.com',
    iosClientId: '397476529560-2r4sckp6flt3c46ocnsi47tarfir8id6.apps.googleusercontent.com',
    iosBundleId: 'com.example.learning',
  );
}
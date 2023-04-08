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
    apiKey: 'AIzaSyBaWxFg2cKaBAGiZg6I1wx9aasAbdcQouI',
    appId: '1:442445390482:web:a0eed7a7af4e98a6047c4b',
    messagingSenderId: '442445390482',
    projectId: 'bosnia-d1a76',
    authDomain: 'bosnia-d1a76.firebaseapp.com',
    storageBucket: 'bosnia-d1a76.appspot.com',
    measurementId: 'G-HF0PVRX5Z4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBr7_leiGD6N6s9tTC8GOvPYVpzCYkJ3kk',
    appId: '1:442445390482:android:5dcff0364a667291047c4b',
    messagingSenderId: '442445390482',
    projectId: 'bosnia-d1a76',
    storageBucket: 'bosnia-d1a76.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD311OInvyzk55wL30hpXEWX79zz5-_HfI',
    appId: '1:442445390482:ios:0bd7da92efbf86c0047c4b',
    messagingSenderId: '442445390482',
    projectId: 'bosnia-d1a76',
    storageBucket: 'bosnia-d1a76.appspot.com',
    iosClientId: '442445390482-jllv6oqrvtngq6g1of864p8ro6bdfpic.apps.googleusercontent.com',
    iosBundleId: 'com.example.mongles',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD311OInvyzk55wL30hpXEWX79zz5-_HfI',
    appId: '1:442445390482:ios:0bd7da92efbf86c0047c4b',
    messagingSenderId: '442445390482',
    projectId: 'bosnia-d1a76',
    storageBucket: 'bosnia-d1a76.appspot.com',
    iosClientId: '442445390482-jllv6oqrvtngq6g1of864p8ro6bdfpic.apps.googleusercontent.com',
    iosBundleId: 'com.example.mongles',
  );
}
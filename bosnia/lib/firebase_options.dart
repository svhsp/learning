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
    apiKey: 'AIzaSyD9-RztbrTwIHuYucQb8ow1_QbzFnYcQnQ',
    appId: '1:115031264807:web:ba34a9662e29119bdf8802',
    messagingSenderId: '115031264807',
    projectId: 'svhsp-heigui-heigui',
    authDomain: 'svhsp-heigui-heigui.firebaseapp.com',
    databaseURL: 'https://svhsp-heigui-heigui-default-rtdb.firebaseio.com',
    storageBucket: 'svhsp-heigui-heigui.appspot.com',
    measurementId: 'G-SD9H2E1R4Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAxKzWLG0j2jkuQOBX9iTW4BENqDjK26Tk',
    appId: '1:115031264807:android:6458a65f27cf6773df8802',
    messagingSenderId: '115031264807',
    projectId: 'svhsp-heigui-heigui',
    databaseURL: 'https://svhsp-heigui-heigui-default-rtdb.firebaseio.com',
    storageBucket: 'svhsp-heigui-heigui.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDQY6fxqNwq3xCC_t_hc-JZiEgVfylRvXA',
    appId: '1:115031264807:ios:7fc3a86dc4d8b7a0df8802',
    messagingSenderId: '115031264807',
    projectId: 'svhsp-heigui-heigui',
    databaseURL: 'https://svhsp-heigui-heigui-default-rtdb.firebaseio.com',
    storageBucket: 'svhsp-heigui-heigui.appspot.com',
    iosClientId: '115031264807-12q9mqrt13gpupuh19ghj445bsn7fgco.apps.googleusercontent.com',
    iosBundleId: 'com.example.bosnia',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDQY6fxqNwq3xCC_t_hc-JZiEgVfylRvXA',
    appId: '1:115031264807:ios:7fc3a86dc4d8b7a0df8802',
    messagingSenderId: '115031264807',
    projectId: 'svhsp-heigui-heigui',
    databaseURL: 'https://svhsp-heigui-heigui-default-rtdb.firebaseio.com',
    storageBucket: 'svhsp-heigui-heigui.appspot.com',
    iosClientId: '115031264807-12q9mqrt13gpupuh19ghj445bsn7fgco.apps.googleusercontent.com',
    iosBundleId: 'com.example.bosnia',
  );
}

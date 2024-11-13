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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDxse6kz27CDRqC38be4rASB6Lz1tJ7G7I',
    appId: '1:242737080427:android:f5735f18d9ca2fb5a8a92e',
    messagingSenderId: '242737080427',
    projectId: 'mahall-manager',
    storageBucket: 'mahall-manager.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBqUGvG7HaE9J0EWGNDRXIHc3znO8M-TEI',
    appId: '1:242737080427:ios:c6d3440495274448a8a92e',
    messagingSenderId: '242737080427',
    projectId: 'mahall-manager',
    storageBucket: 'mahall-manager.firebasestorage.app',
    iosBundleId: 'com.example.mahallManager',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBXxFa4sC8ANxJLI1RJsLN3SG_-v0ZB0fw',
    appId: '1:242737080427:web:6b6f6948ce3e2c2ca8a92e',
    messagingSenderId: '242737080427',
    projectId: 'mahall-manager',
    authDomain: 'mahall-manager.firebaseapp.com',
    storageBucket: 'mahall-manager.firebasestorage.app',
    measurementId: 'G-M7PNRMWG1Q',
  );

}
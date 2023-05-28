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
    apiKey: 'AIzaSyAuknbi7HkroYErtYWTgXt5sv2OlqbXxxc',
    appId: '1:879590032897:web:e4c8604ee49ab07140e200',
    messagingSenderId: '879590032897',
    projectId: 'mysaving-b5915',
    authDomain: 'mysaving-b5915.firebaseapp.com',
    storageBucket: 'mysaving-b5915.appspot.com',
    measurementId: 'G-61B54GP53L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDd99QDN0_D4HeQYCgPORfzAOdYpGIEDSU',
    appId: '1:879590032897:android:fe793783a775871f40e200',
    messagingSenderId: '879590032897',
    projectId: 'mysaving-b5915',
    storageBucket: 'mysaving-b5915.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBMiv9V7jQthGHjFn4vRY_xNEiTyx91HWM',
    appId: '1:879590032897:ios:a2ad79563f00879b40e200',
    messagingSenderId: '879590032897',
    projectId: 'mysaving-b5915',
    storageBucket: 'mysaving-b5915.appspot.com',
    iosClientId: '879590032897-1c32ev98l7e5mnhuq72rilc4d6toaceq.apps.googleusercontent.com',
    iosBundleId: 'com.example.mysavingapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBMiv9V7jQthGHjFn4vRY_xNEiTyx91HWM',
    appId: '1:879590032897:ios:a2ad79563f00879b40e200',
    messagingSenderId: '879590032897',
    projectId: 'mysaving-b5915',
    storageBucket: 'mysaving-b5915.appspot.com',
    iosClientId: '879590032897-1c32ev98l7e5mnhuq72rilc4d6toaceq.apps.googleusercontent.com',
    iosBundleId: 'com.example.mysavingapp',
  );
}

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
    apiKey: 'AIzaSyApho9-MA_DekenNUCMtbiOIABmEejZr2A',
    appId: '1:844704254805:web:aff2c8abe49eeaf298fddc',
    messagingSenderId: '844704254805',
    projectId: 'rosabon-75ee4',
    authDomain: 'rosabon-75ee4.firebaseapp.com',
    storageBucket: 'rosabon-75ee4.appspot.com',
    measurementId: 'G-YQ776BNKKR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDlQjpzCwpqbC3NbQNdpq0jHLHeoEN7lrU',
    appId: '1:844704254805:android:521ceb59d920d10c98fddc',
    messagingSenderId: '844704254805',
    projectId: 'rosabon-75ee4',
    storageBucket: 'rosabon-75ee4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCzMzFr9oGPHogSfsXIMTBVh3UO6Tf2x-M',
    appId: '1:844704254805:ios:0aa392498521d23698fddc',
    messagingSenderId: '844704254805',
    projectId: 'rosabon-75ee4',
    storageBucket: 'rosabon-75ee4.appspot.com',
    iosClientId: '844704254805-m41igm3o7aovm5pr0lib9qb9pp8ieren.apps.googleusercontent.com',
    iosBundleId: 'com.example.rosabon',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCzMzFr9oGPHogSfsXIMTBVh3UO6Tf2x-M',
    appId: '1:844704254805:ios:0aa392498521d23698fddc',
    messagingSenderId: '844704254805',
    projectId: 'rosabon-75ee4',
    storageBucket: 'rosabon-75ee4.appspot.com',
    iosClientId: '844704254805-m41igm3o7aovm5pr0lib9qb9pp8ieren.apps.googleusercontent.com',
    iosBundleId: 'com.example.rosabon',
  );
}

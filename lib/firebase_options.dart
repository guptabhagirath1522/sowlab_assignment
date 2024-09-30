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
    apiKey: 'AIzaSyCY3hnmVJqpmL7VZgKbPKSEu_ZZziu7tPg',
    appId: '1:117693004669:web:66b041f2c61577e435aa14',
    messagingSenderId: '117693004669',
    projectId: 'softwarelabs-10740',
    authDomain: 'softwarelabs-10740.firebaseapp.com',
    databaseURL: 'https://softwarelabs-10740-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'softwarelabs-10740.appspot.com',
    measurementId: 'G-KGD6Z87MX4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-FIoguVthmFFXe-TD8nEz57SkazJMnRk',
    appId: '1:117693004669:android:306255086fe3470d35aa14',
    messagingSenderId: '117693004669',
    projectId: 'softwarelabs-10740',
    databaseURL: 'https://softwarelabs-10740-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'softwarelabs-10740.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAKiADpGi4FClGRhWnHwYdOEX5F2_qRgFI',
    appId: '1:117693004669:ios:8533a65d3eb3ee2835aa14',
    messagingSenderId: '117693004669',
    projectId: 'softwarelabs-10740',
    databaseURL: 'https://softwarelabs-10740-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'softwarelabs-10740.appspot.com',
    iosClientId: '117693004669-9sgm1hn46241vhhrs11g8uisb4gppcpg.apps.googleusercontent.com',
    iosBundleId: 'com.example.sowlabAssignment',
  );

}
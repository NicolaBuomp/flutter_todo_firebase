import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyAsQtp8TLnRNbtEuLK17I16v1K0uYss08g',
    appId: '1:547436192907:web:bdd47dcfb47dac93a7a08e',
    messagingSenderId: '547436192907',
    projectId: 'rn-todofireapp',
    authDomain: 'rn-todofireapp.firebaseapp.com',
    databaseURL:
        'https://rn-todofireapp-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'rn-todofireapp.appspot.com',
    measurementId: 'G-FBFF9GN0CS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBK7svRQjflcyy1RTQmtXpwLPWJJpbl5ms',
    appId: '1:547436192907:android:505c58c257bce9afa7a08e',
    messagingSenderId: '547436192907',
    projectId: 'rn-todofireapp',
    databaseURL:
        'https://rn-todofireapp-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'rn-todofireapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyChFCMG2NmryqA0TndxwjLLOs77_HrVmEA',
    appId: '1:547436192907:ios:260276c4057a2c38a7a08e',
    messagingSenderId: '547436192907',
    projectId: 'rn-todofireapp',
    databaseURL:
        'https://rn-todofireapp-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'rn-todofireapp.appspot.com',
    iosBundleId: 'com.example.flutterTodoFirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyChFCMG2NmryqA0TndxwjLLOs77_HrVmEA',
    appId: '1:547436192907:ios:9268567752881b74a7a08e',
    messagingSenderId: '547436192907',
    projectId: 'rn-todofireapp',
    databaseURL:
        'https://rn-todofireapp-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'rn-todofireapp.appspot.com',
    iosBundleId: 'com.example.flutterTodoFirebase.RunnerTests',
  );
}

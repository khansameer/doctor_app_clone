// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // ignore: missing_enum_constant_in_switch
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
      case TargetPlatform.fuchsia:
      // TODO: Handle this case.
      case TargetPlatform.linux:
      // TODO: Handle this case.
      case TargetPlatform.windows:
        return web;
      // TODO: Handle this case.
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPXs5xxAk4aQXielzxSGb5PhXBAzSY1ak',
    appId: '1:266192838254:android:191ba3899ef5fe26ab107f',
    messagingSenderId: '266192838254',
    projectId: 'junohealthapp',
    storageBucket: 'junohealthapp.firebasestorage.app',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    iosBundleId: 'com.quarks.daddyinsurance',
    apiKey: 'AIzaSyBs7Ep-hWlKOVT9NNccTsQoquhFxI-2b1Q',
    appId: '1:462307133199:ios:c44207eaa0b628bdbfe07a',
    messagingSenderId: '462307133199',
    projectId: 'daddy-insurance',
    storageBucket: 'daddy-insurance.appspot.com',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyBfuv_9R0YhgqoqlDLZE51izZqatlij4T0",
    authDomain: "junohealthapp.firebaseapp.com",
    // databaseURL: "https://daddy-insurance-default-rtdb.firebaseio.com",
    projectId: "junohealthapp",
    storageBucket: "junohealthapp.firebasestorage.app",
    messagingSenderId: "266192838254",
    appId:
        "1:266192838254:web:0b52403a559fa93bab107f", /*measurementId: "G-YCMH02VVEH"*/
  );
}
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError('No Firebase config for web');
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return const FirebaseOptions(
          apiKey: 'android-api-key',
          appId: '1:1234567890:android:abcdef',
          messagingSenderId: '1234567890',
          projectId: 'naturkind-app',
        );
      default:
        throw UnsupportedError('Unsupported platform');
    }
  }
}


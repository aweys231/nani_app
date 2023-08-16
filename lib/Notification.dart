import 'package:firebase_messaging/firebase_messaging.dart' as nt;

class FirebaseMessagingService {
  final nt.FirebaseMessaging _firebaseMessaging = nt.FirebaseMessaging.instance;



  Future initialize() async {
    // Request permission for receiving push notifications (optional)
    await _firebaseMessaging.requestPermission();

    // Configure FCM message handling
    nt.FirebaseMessaging.onMessage.listen((nt.RemoteMessage message) {
      print('Received FCM message: ${message.notification?.title}');
    });

    // Configure FCM background message handling (optional)
    nt.FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Background message handler function (optional)
  Future<void> _firebaseMessagingBackgroundHandler(nt.RemoteMessage message) async {
    print('Received FCM background message: ${message.notification?.title}');
  }
}
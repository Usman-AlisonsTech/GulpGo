import 'package:aqua_flow/services/local_notification_service.dart';
import 'package:aqua_flow/views/bottombar/bottom_navigation_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FirebaseMessagingService {
  // Private constructor for singleton pattern
  FirebaseMessagingService._internal();

  // Singleton instance
  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._internal();

  // Factory constructor to provide singleton instance
  factory FirebaseMessagingService.instance() => _instance;

  // Reference to local notifications service for displaying notifications
  LocalNotificationsService? _localNotificationsService;

  // Local storage instance
  final _storage = GetStorage();

  /// Initialize Firebase Messaging and sets up all message listeners
  Future<void> init(
      {required LocalNotificationsService localNotificationsService}) async {
    _localNotificationsService = localNotificationsService;

    // 1. Request permission first
    await _requestPermission();

    // 2. Ensure APNs token is set on iOS
    if (GetPlatform.isIOS) {
      final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      print("APNs Token: $apnsToken");
      if (apnsToken == null) {
        print("⚠️ APNs token not set yet. FCM token cannot be fetched.");
        return; // Exit until APNs token is available
      }
    }

    // 3. Now handle FCM token after APNs token is ready
    await _handlePushNotificationsToken();

    // ✅ Set foreground notification options (iOS only)
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _onMessageOpenedApp(initialMessage);
    }
  }

  /// Retrieves and manages the FCM token for push notifications
  Future<void> _handlePushNotificationsToken() async {
    // Try to read existing token from storage
    String? savedToken = _storage.read('fcmToken');

    if (savedToken != null) {
      print('FCM token from storage: $savedToken');
    } else {
      // Get the FCM token for the device
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        print('Push notifications token: $token');
        _storage.write('fcmToken', token);
      }
    }

    // Listen for token refresh events
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      print('FCM token refreshed: $fcmToken');
      _storage.write('fcmToken', fcmToken);
      // Optionally send token to your server here
    }).onError((error) {
      // Handle errors during token refresh
      print('Error refreshing FCM token: $error');
    });
  }

  /// Requests notification permission from the user
  Future<void> _requestPermission() async {
    // Request permission for alerts, badges, and sounds
    final result = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Log the user's permission decision
    print('User granted permission: ${result.authorizationStatus}');
  }

  /// Handles messages received while the app is in the foreground
  void _onForegroundMessage(RemoteMessage message) {
    print('Foreground message received: ${message.data}');
    final notificationData = message.notification;
    if (notificationData != null) {
      _localNotificationsService?.showNotification(
        notificationData.title,
        notificationData.body,
        message.data.toString(),
      );
    }
  }

  /// Handles notification taps when app is opened from the background or terminated state
  void _onMessageOpenedApp(RemoteMessage message) {
    print('Notification caused the app to open: ${message.data}');
    // TODO: Add navigation or specific handling based on message data
    Future.delayed(const Duration(milliseconds: 300), () {
      try {
        final controller = Get.find<BottomNavbarController>();
        // controller.changeIndex(0); // 👈 4 = Notification tab
        if (message.data['type'] == 'payment') {
          controller.changeIndex(2);
        } else {
          controller.changeIndex(0);
        }
      } catch (e) {
        print('⚠️ BottomNavbarController not found yet: $e');
        // If not found (e.g., app just launched), schedule after app builds
        everReady(data: message.data);
      }
    });
  }
}

// void everReady() {
//   Future.delayed(const Duration(seconds: 2), () {
//     if (Get.isRegistered<BottomNavbarController>()) {
//       BottomNavbarController.to.changeIndex(0);
//     } else {
//       everReady();
//     }
//   });
// }

void everReady({Map<String, dynamic>? data}) {
  Future.delayed(const Duration(seconds: 2), () {
    if (Get.isRegistered<BottomNavbarController>()) {
      if (data?['type'] == 'payment') {
        BottomNavbarController.to.changeIndex(2);
      } else {
        BottomNavbarController.to.changeIndex(0);
      }
    } else {
      everReady(data: data);
    }
  });
}

/// Background message handler (must be top-level function or static)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Background message received: ${message.data}');
}

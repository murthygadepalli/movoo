import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalHelper{
  static Future<String?> getCurrentUserSubId() async {
    // Get the device state from OneSignal
    String? subId = await OneSignal.User.pushSubscription.id;
    return subId;  // Return null if no subscription ID is found
  }
}
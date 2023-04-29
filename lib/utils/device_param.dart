import 'dart:io';
import 'package:flutter_instagram_clone/service/prefs_service.dart';
import 'package:platform_device_id/platform_device_id.dart';

Future<Map<String, String>> deviceParams() async {
  Map<String, String> params = {};
  var getDeviceId = await PlatformDeviceId.getDeviceId;
  String fcmToken = await Prefs.loadFCM();

  if (Platform.isIOS) {
    params.addAll({
      'deviceId': getDeviceId!,
      'deviceType': "I",
      'deviceToken': fcmToken,
    });
  } else {
    params.addAll({
      'deviceId': getDeviceId!,
      'deviceType': "A",
      'deviceToken': fcmToken,
    });
  }
  return params;
}

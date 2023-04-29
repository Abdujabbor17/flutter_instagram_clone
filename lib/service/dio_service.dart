

import 'package:dio/dio.dart';
import 'package:flutter_instagram_clone/utils/log_service.dart';

class DioService{


  static String baseUrl = 'https://fcm.googleapis.com/fcm/send';
  static String serverKey = 'key=AAAABI2BhvQ:APA91bGY2d-hFARxy3VdwF3bfFtRvYiQbcLapTbuNNMubXRYo_4vcIEbsyDaFWPvCyQh3IpdRmRV--WH_ToTXMTWvOIz5IVw6yoJWdPVjv3yIVjK89mKUPDNU87-G-9mry3udx6KGIWr';


  static Future sendNotification(String token,String fullName) async {
    Log.wtf(token);
    try {
      Response res = await Dio().post(
          baseUrl, data: {
        "notification": {
          "title": "Instagram",
          "body": "$fullName followed you"
        },
        "click_action" : "FLUTTER_NOTIFICATION_CLICK",
        "registration_ids": [
          token
        ]
      },
        options: Options(headers:{
            'Authorization': serverKey,
            })

      );
      Log.i(res.data.toString());
      Log.i(res.statusCode.toString());

      if (res.statusCode == 200 || res.statusCode == 201) {
        return res.data;
      } else {
        Log.e("${res.statusMessage} ${res.statusCode}");
      }
    } on DioError catch (e) {

      Log.e(e.response!.toString());
    } catch (e) {
      Log.e(e.toString());

    }
  }

}
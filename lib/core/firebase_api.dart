import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ratailapp/core/access_token.dart';

class FirebaseApi {
  static Future<void> sendMessage(
      String title, String description, String token) async {

    final accessToken = await AccessTokenFirebase().getAccessToken();

    http.post(
      Uri.parse(
          'https://fcm.googleapis.com/v1/projects/retailappstore/messages:send'),
      headers: {
        'Content-Type' : 'application/json',
        'Authorization' : 'Bearer $accessToken'
      },
      body: jsonEncode(   {
        "message" : {
          "token" : token,
          "notification" : {
            "body" : title,
            "title" : description,
          }
        }
      }),
    );
  }
}

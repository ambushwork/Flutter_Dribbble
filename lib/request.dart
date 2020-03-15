import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart' as constants;

Future<http.Response> getAuthRequest() async {
  var map = Map<String, dynamic>();
  map['client_id'] =
      "989ad6470d93f9da2e30239db61377742cc59ffb2657f577bc2ee5f99e960c34";
  http.Response response = await http.post(constants.uri, body: map);

  return response;
}

startDribbbleAuth() {
  FlutterWebAuth.authenticate(
      url: getAuthUri().toString(), callbackUrlScheme: constants.scheme_host);
}

Uri getAuthUri() {
  return Uri.http(constants.dribbble_host, constants.auth_scope,
      {constants.client_id_key: constants.client_id});
}

Uri getTokenUri() {
  return Uri.https(constants.dribbble_host, constants.token_scope);
}

getAccessToken(String code) {
  http
      .post(
    getTokenUri().toString(),
    headers: getPostHeader(),
    body: jsonEncode({
      constants.client_id_key: constants.client_id,
      'client_secret': constants.client_secret,
      'code': code
    }),
  )
      .then((response) {
    log("ResponseBody: ${response.body}");
    persistAccessToken(parseResponse(response.body));
  });
}

persistAccessToken(String accessToken) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("access_token", accessToken);
}

Future<String> queryAccessToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("access_token");
}

Future<String> requestUserProfile() async {
  var map = Map<String, String>();
  map['access_token'] = await queryAccessToken();
  http.Response response = await http
      .get(Uri.https(constants.base_api, constants.endpoint_profile, map));
  return response.body;
}

String parseResponse(String body) {
  var parsedJson = json.decode(body);
  return parsedJson['access_token'];
}

Map<String, String> getPostHeader() {
  return {'Content-Type': 'application/json; charset=utf-8'};
}

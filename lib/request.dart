import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;

import 'constants.dart' as constants;

Future<http.Response> getAuthRequest() async {
  var map = Map<String, dynamic>();
  map['client_id'] =
      "989ad6470d93f9da2e30239db61377742cc59ffb2657f577bc2ee5f99e960c34";
  http.Response response = await http.post(constants.uri, body: map);

  return response;
}

Future<String> startDribbbleAuth() async {
  return await FlutterWebAuth.authenticate(
      url: getAuthUri().toString(), callbackUrlScheme: constants.scheme_host);
}

Uri getAuthUri() {
  return Uri.http(constants.dribbble_host, constants.auth_scope,
      {constants.client_id_key: constants.client_id});
}

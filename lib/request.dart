import 'package:http/http.dart' as http;
final uri = "dribbble.com/oauth/authorize";


Future<http.Response> getAuthRequest() async {
  var map = Map<String, dynamic>();
  map['client_id'] = "989ad6470d93f9da2e30239db61377742cc59ffb2657f577bc2ee5f99e960c34";
  http.Response response = await http.post(uri, body: map);

  return response;
}


Uri getAuthUri(){
  return Uri.http('dribbble.com',
      'oauth/authorize',
      {'client_id':'989ad6470d93f9da2e30239db61377742cc59ffb2657f577bc2ee5f99e960c34'});
}


Uri getTestUri(){
  return Uri.http('google.com', '/');
}
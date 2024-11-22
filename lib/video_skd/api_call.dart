
import 'dart:convert';

import 'package:http/http.dart' as http;
String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiIyYmNhN2IwYS03MGZiLTRkMGUtOGU1ZC1hOWYzZGQ5ZmVlMDkiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTczMTgzMjAwOSwiZXhwIjoxNzQ3Mzg0MDA5fQ.TYhJymQVwYDs8MaK1bpAMXzi4J9x8znJCYl0Mvpj3iY";

// API call to create meeting
Future<String> createMeeting() async {
  final http.Response httpResponse = await http.post(
    Uri.parse("https://api.videosdk.live/v2/rooms"),
    headers: {'Authorization': token},
  );


  print('===asasaaaasas=====${json.decode(httpResponse.body)}');
//Destructuring the roomId from the response
  return json.decode(httpResponse.body)['roomId'];
}
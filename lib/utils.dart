import 'package:http/http.dart' as http;
import 'dart:convert';

String host = '35.194.86.100:5000';

Future<http.Response> sendRequest(String url, String method, var body) async {
  var response;
  if (method == 'POST') {
    response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );
  } else {
    response = await http.get(url);
  }

  
  return response;
}

dynamic getJsonResponse(http.Response response) {
  var jsonBody = json.decode(response.body);
  return jsonBody;
}

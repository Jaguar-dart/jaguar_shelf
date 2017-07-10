library jaguar_shelf.example.simple.client;

import 'dart:async';

import 'package:http/http.dart' as http;

const String kHostname = 'localhost';

const int kPort = 8080;

final http.Client _client = new http.Client();

Future<Null> printHttpClientResponse(http.Response resp) async {
  print('=========================');
  print("body:");
  print(resp.body);
  print("statusCode:");
  print(resp.statusCode);
  print("headers:");
  print(resp.headers);
  print('=========================');
}

Future<Null> execSomeRoute() async {
  String url = "http://$kHostname:$kPort/some/route";
  http.Response resp = await _client.get(url);

  printHttpClientResponse(resp);
}

main() async {
  await execSomeRoute();
}

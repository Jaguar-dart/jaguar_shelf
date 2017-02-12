library jaguar_shelf.example.simple.client;

import 'dart:io';
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
  String url = "http://$kHostname:$kPort/later";
  http.Response resp = await _client.get(url);

  await printHttpClientResponse(resp);
}

Future<Null> execGreeting2() async {
  final uri = new Uri.http(
      '$kHostname:$kPort', '/greeting2/teja', {'age': '28'});
  http.Response resp = await _client.get(uri);

  await printHttpClientResponse(resp);
}

main() async {
  await execSomeRoute();
  await execGreeting2();
  exit(0);
}

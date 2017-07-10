// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io' show HttpHeaders, HttpStatus;
import 'package:jaguar/jaguar.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf;

Future<shelf.Request> jaguarToShelfRequest(Request request) async {
  var headers = <String, String>{};
  request.headers.forEach((k, v) {
    // Multiple header values are joined with commas.
    // See http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging-21#page-22
    headers[k] = v.join(',');
  });

  // Remove the Transfer-Encoding header per the adapter requirements.
  headers.remove(HttpHeaders.TRANSFER_ENCODING);

  return new shelf.Request(request.method, request.requestedUri,
      protocolVersion: request.protocolVersion,
      headers: headers,
      body: await request.bodyAsStream);
}

Response<Stream<List<int>>> shelfToJaguarResponse(shelf.Response incoming) {
  final ret = new Response<Stream<List<int>>>(incoming.read(),
      statusCode: incoming.statusCode);
  incoming.headers.forEach((String header, String value) {
    if (value == null) return;
    ret.headers.set(header, value);
  });
  return ret;
}

class ShelfHandler implements RequestHandler {
  final shelf.Handler _handler;

  ShelfHandler(this._handler);

  Future<Response> handleRequest(Context ctx, {String prefix}) async {
    shelf.Request shelfReq = await jaguarToShelfRequest(ctx.req);
    shelf.Response resp = await _handler(shelfReq);
    if (resp.statusCode == HttpStatus.NOT_FOUND) return null;
    return shelfToJaguarResponse(resp);
  }
}

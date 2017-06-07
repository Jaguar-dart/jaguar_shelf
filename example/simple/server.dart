// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:jaguar_shelf/jaguar_shelf.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:jaguar/jaguar.dart';

main() async {
  shelf.Response echoHandler(shelf.Request request) =>
      new shelf.Response.ok("You've requested ${request.url}");
  final shelfHandler = new ShelfHandler(echoHandler);

  Jaguar server = new Jaguar();
  server.addApi(shelfHandler);
  await server.serve();
}

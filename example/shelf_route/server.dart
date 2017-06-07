// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:jaguar_shelf/jaguar_shelf.dart';
import 'package:jaguar/jaguar.dart';
import 'shelf_handlers.dart';

main() async {
  final handler = makeHandler();
  Jaguar server = new Jaguar();
  server.addApi(new ShelfHandler(handler));
  await server.serve();
}

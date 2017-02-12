# jaguar_shelf

Shelf integration for Jaguar. Use shelf handlers and middleware in Jaguar

## Usage

A simple usage example:

```dart
import 'package:jaguar_shelf/jaguar_shelf.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:jaguar/jaguar.dart';

main() async {
  shelf.Response echoHandler(shelf.Request request) =>
      new shelf.Response.ok("You've requested ${request.url}");
  final shelfHandler = new ShelfHandler(echoHandler);

  Configuration conf = new Configuration();
  conf.addApi(shelfHandler);
  await serve(conf);
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/Jaguar-dart/jaguar_shelf/issues

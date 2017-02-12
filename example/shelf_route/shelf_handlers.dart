import 'package:shelf/shelf.dart';
import 'package:shelf_route/shelf_route.dart' as route;
import 'package:shelf_bind/shelf_bind.dart';
import 'package:http_exception/http_exception.dart';
import 'package:shelf_exception_handler/shelf_exception_handler.dart';
import 'dart:async';

Handler makeHandler() {
  var router = route.router(handlerAdapter: handlerAdapter())
    ..get('/', () => "Hello World")
    ..get('/later', () => new Future.value("Hello World"))
    ..get('/map', () => {"greeting": "Hello World"})
    ..get('/object', () => new SayHello()..greeting = "Hello World")
    ..get('/ohnoes', () => throw new BadRequestException())
    ..get('/response', () => new Response.ok("Hello World"))
    ..get('/greeting/{name}', (String name) => "Hello $name")
    ..get('/greeting2/{name}{?age}',
        (String name, int age) => "Hello $name of age $age")
    ..get('/greeting3/{name}', (Person person) => "Hello ${person.name}")
    ..get('/greeting5/{name}',
        (String name, Request request) => "Hello $name ${request.method}")
    ..post('/greeting6', (Person person) => "Hello ${person.name}")
    ..get('/greeting8{?name}',
        (@PathParams() Person person) => "Hello ${person.name}");

  var handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(exceptionHandler())
      .addHandler(router.handler);

  route.printRoutes(router);

  return handler;
}

class SayHello {
  String greeting;

  Map toJson() => {'greeting': greeting};
}

class Person {
  final String name;

  Person.build({this.name});

  Person.fromJson(Map json) : this.name = json['name'];

  Map toJson() => {'name': name};
}

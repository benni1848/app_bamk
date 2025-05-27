/*import 'dart:io';
import '../bin/db.dart';
import '../bin/handlers.dart';

Future<void> startServer() async {
  var database = Database();
  await database.connect();

  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);
  print('Server läuft auf http://${server.address.host}:${server.port}');

  await for (HttpRequest request in server) {
    RequestHandler.handleRequest(request);
  }
}*/

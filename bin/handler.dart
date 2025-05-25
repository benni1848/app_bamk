import 'dart:io';
import 'auth.dart';

class RequestHandler {
  static void handleRequest(HttpRequest request) async {
    if (request.uri.path == '/auth' && request.method == 'GET') {
      final token = request.uri.queryParameters['token'];
      if (token != null && Auth.verifyToken(token)) {
        request.response.write('Token gültig');
      } else {
        request.response.write('Token ungültig');
      }
      await request.response.close();
    } else {
      request.response.write('404 - Nicht gefunden');
      await request.response.close();
    }
  }
}

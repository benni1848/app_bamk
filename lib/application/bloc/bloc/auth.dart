import 'package:jwt/jwt.dart';

class Auth {
  static const String secret = 'dein_geheimer_schlüssel';

  static String generateToken(String userId) {
    final token = JWT({'userId': userId})
        .sign(SecretKey(secret), expiresIn: Duration(hours: 3));
    return token;
  }

  static bool verifyToken(String token) {
    try {
      final jwt = JWT.verify(token, SecretKey(secret));
      return jwt.payload.containsKey('userId');
    } catch (e) {
      return false;
    }
  }
}

import 'package:dotenv/dotenv.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class JwtHelper {
  static final String _jwtSecrety = env['JWT_SECRET'] ?? env['jwtSecretyDev']!;

  JwtHelper._();

  static JwtClaim getClaims(String token) {
    return verifyJwtHS256Signature(token, _jwtSecrety);
  }
}

import 'package:dotenv/dotenv.dart';

void main() {
  final dotenv = Dotenv()..load();
  print("MongoDB URI: ${dotenv['MONGO_URI']}");
}

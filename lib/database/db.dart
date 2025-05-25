import 'package:mongo_dart/mongo_dart.dart';
import 'package:dotenv/dotenv.dart';

class Database {
  late Db db;

  Future<void> connect() async {
    var env = DotEnv()..load();
    String mongoUrl = env['MONGO_URL']!;

    db = Db(mongoUrl);
    await db.open();
    print('MongoDB verbunden!');
  }
}

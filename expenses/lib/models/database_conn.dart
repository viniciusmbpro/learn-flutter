import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  Future setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_exp.db');
    var database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future _createDatabase(Database database, int version) async {
    String sql =
        "CREATE TABLE transactions (id INTEGER PRIMARY KEY, title TEXT NOT NULL, value REAL, date TEXT);";
    await database.execute(sql);
  }
}

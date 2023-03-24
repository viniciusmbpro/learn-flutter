import 'database_conn.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late DatabaseConnection _databaseConnection;
  Repository() {
    _databaseConnection = DatabaseConnection();
  }
  static Database? _database;
  Future get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  insertData(table, data) async {
    var conexao = await database;
    print("Testando | insertData $conexao | $table, $data");

    return await conexao?.insert(table, {
      "id": data['id'],
      "title": data['title'],
      "value": data['value'],
      "date": data['date']
    });
  }

  readData(table) async {
    var conexao = await database;
    return await conexao?.query(table);
  }

  readDataById(table, itemId) async {
    var conexao = await database;
    return await conexao?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  updateData(table, data) async {
    var conexao = await database;
    return await conexao?.update(
        table,
        {
          "id": data['id'],
          "title": data['title'],
          "value": data['value'],
          "date": data['date']
        },
        where: 'id=?',
        whereArgs: [data['id']]);
  }

  deleteDataById(table, itemId) async {
    var conexao = await database;
    return await conexao
        ?.rawDelete("delete from $table where id = ?", [itemId]);
  }
}

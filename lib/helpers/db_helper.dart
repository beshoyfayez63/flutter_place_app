import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    print('dbPath $dbPath');
    return await sql.openDatabase('$dbPath/user_places.db',
        onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)',
      );
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await database();
    return db.query(table);
  }
}

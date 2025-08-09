import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/bird_model.dart';

class DatabaseService {
  static Database? _database;
  static const String _tableName = 'bird_records';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'birds.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        imagePath TEXT NOT NULL,
        birdName TEXT NOT NULL,
        confidence REAL NOT NULL,
        dateTime TEXT NOT NULL,
        location TEXT
      )
    ''');
  }

  Future<int> insertBirdRecord(BirdRecord record) async {
    final db = await database;
    return await db.insert(_tableName, record.toMap());
  }

  Future<List<BirdRecord>> getAllBirdRecords() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      orderBy: 'dateTime DESC',
    );

    return List.generate(maps.length, (i) {
      return BirdRecord.fromMap(maps[i]);
    });
  }

  Future<List<BirdRecord>> getBirdRecordsByName(String birdName) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'birdName = ?',
      whereArgs: [birdName],
      orderBy: 'dateTime DESC',
    );

    return List.generate(maps.length, (i) {
      return BirdRecord.fromMap(maps[i]);
    });
  }

  Future<int> deleteBirdRecord(int id) async {
    final db = await database;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateBirdRecord(BirdRecord record) async {
    final db = await database;
    return await db.update(
      _tableName,
      record.toMap(),
      where: 'id = ?',
      whereArgs: [record.id],
    );
  }

  Future<Map<String, int>> getBirdStats() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT birdName, COUNT(*) as count 
      FROM $_tableName 
      GROUP BY birdName 
      ORDER BY count DESC
    ''');

    Map<String, int> stats = {};
    for (var row in result) {
      stats[row['birdName']] = row['count'];
    }
    return stats;
  }
}
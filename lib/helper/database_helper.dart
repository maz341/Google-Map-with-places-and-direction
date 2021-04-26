import 'dart:io' show Directory;
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;

class DatabaseHelper {

  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'wishlist_places';

  static final columnId = '_id';
  static final columnPlaceId = 'place_id';
  static final columnTitle = 'title';
  static final columnDescription = 'description';
  static final columnRating = 'rating';
  static final columnDistance = 'distance';
  static final columnImage = 'image';
  static final columnLat = 'lat';
  static final columnLong = 'long';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnPlaceId INTEGER NOT NULL,
            $columnTitle TEXT NOT NULL,
            $columnDescription TEXT NOT NULL,
            $columnRating DOUBLE NOT NULL,
            $columnDistance DOUBLE NOT NULL,
            $columnImage TEXT NOT NULL,
            $columnLat DOUBLE NOT NULL,
            $columnLong DOUBLE NOT NULL
          )
          ''');
  }
}
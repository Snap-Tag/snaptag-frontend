import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'tags_db.dart';

class DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'tags.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    await deleteDatabase(path);
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );
    print("database created");
    return database;
  }

  Future<void> create(Database database, int version) async =>
      await TagsDB().createTable(database);
}

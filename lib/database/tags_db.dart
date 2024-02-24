import 'package:sqflite/sqflite.dart';
import 'package:snaptag_frontend/database/databaseservice.dart';
import 'package:snaptag_frontend/models/tags.dart';

class TagsDB {
  final tableName = 'tags';

  Future<void> createTable(Database database) async {
    await database.execute(""" CREATE TABLE IF NOT EXIST $tableName (
      "id" TEXT NOT NULL,
      "TAGS" TEXT ,
    );
""");
  }
}

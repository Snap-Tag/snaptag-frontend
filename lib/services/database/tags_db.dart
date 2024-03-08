import 'package:sqflite/sqflite.dart';
import 'package:snaptag_frontend/services/database/databaseservice.dart';
import 'package:snaptag_frontend/models/image.dart';

class TagsDB {
  static Database? _database;

  // Getter method to access the static database instance
  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    // Initialize the database if it's null
    _database = await DatabaseService().database;
    return _database!;
  }

  Future<void> createTable(Database database) async {
    await database.execute('''DROP TABLE IF EXISTS images''');

    await database.execute('''CREATE TABLE IF NOT EXISTS images (
      image_id INTEGER PRIMARY KEY AUTOINCREMENT,
      image_data BLOB,
      favorite BOOLEAN DEFAULT 0,
      created_at INTEGER,
      updated_at INTEGER
    );''');

    await database.execute('''CREATE TABLE IF NOT EXISTS tags (
      tag_id INTEGER PRIMARY KEY AUTOINCREMENT,
      tag_name TEXT NOT NULL
    );''');

    await database.execute('''CREATE TABLE IF NOT EXISTS image_tags (
      image_id TEXT NOT NULL,
      tag_id TEXT NOT NULL,
      FOREIGN KEY (image_id) REFERENCES images (image_id) ON UPDATE CASCADE ON DELETE CASCADE,
      FOREIGN KEY (tag_id) REFERENCES tags (tag_id) ON UPDATE CASCADE ON DELETE CASCADE
    );''');
  }

  Future<List<Images>> searchTags(String tag) async {
    // Database R= await DatabaseService().database;
    // dynamic tagid =
    //     await database.rawQuery('SELECT tagID FROM tags WHERE tags = $tag');
    // dynamic imageid = await database
    //     .rawQuery('SELECT imageID FROM imageTags WHERE tags = $tagid');
    // dynamic imagepath = await database
    //     .rawQuery('SELECT image_path FROM image WHERE tags = $imageid');
    // return imagepath
    //     .map((image) => Image.fromSqfliteDatabase(imageid))
    //     .toList();

    // Step 1: Obtain a reference to the database
    Database database = await DatabaseService().database;
    dynamic img = database.rawQuery('SELECT * FROM images');
    print(img);
    dynamic imagePaths = [];
    // Step 2: Use parameterized query to prevent SQL injection
    dynamic tagidResult = await database
        .rawQuery('SELECT tag_id FROM tags WHERE tag_name = ?', [tag]);
    List tagidList = List.from(tagidResult);
    // Step 3: Check if tagid is not empty before proceeding with the next queries
    if (tagidList.isEmpty) {
      return []; // or handle the case when the tag doesn't exist
    }

    for (var tagid in tagidList) {
      // Step 4: Use proper column names and handle query results
      dynamic imageidResult = await database.rawQuery(
          'SELECT image_id FROM image_tags WHERE tag_id = ?', tagidList[tagid]);

      // Step 5: Check if there are no images for the given tag
      if (imageidResult.isEmpty) {
        return []; // or handle the case when there are no images for the given tag
      }

      // Step 6: Iterate through the result and retrieve image paths
      List imageidList = List.from(imageidResult);

      for (var entry in imageidList) {
        // Step 7: Use parameterized query to prevent SQL injection
        dynamic imagePathResult = await database.rawQuery(
            'SELECT image_data FROM images WHERE image_id = ?',
            imageidList[entry]);

        // Step 8: Check if imagePathResult is not empty before extracting the path
        if (imagePathResult.isNotEmpty) {
          for (var imagepaths in imagePathResult) {
            imagePaths.add(imagePathResult[imagepaths]);
          }
        }
      }
    }

    // Step 9: Create Image objects from the paths
    return imagePaths.map((path) => Images.fromSqfliteDatabase(path)).toList();
  }

  Future<List<dynamic>> getRecentNotes() async {
    Database database = await DatabaseService().database;
    // dynamic hehe = await database.rawQuery("SELECT * FROM images;");
    // print(hehe);
    dynamic savedList = await database.rawQuery('SELECT * FROM images LIMIT 5');
    print(savedList);
    return savedList.map((row) => Images.fromSqfliteDatabase(row)).toList();
  }

  Future<List<dynamic>> getFavoriteNotes() async {
    Database database = await DatabaseService().database;
    // dynamic hehe = await database.rawQuery("SELECT * FROM images;");
    // print(hehe);
    dynamic favoriteList = await database
        .rawQuery('SELECT image_data FROM images WHERE favorite = 1');
    return favoriteList.map((row) => Images.fromSqfliteDatabase(row)).toList();
  }

  Future saveNote(image, tags) async {
    final imageId = await _database!
        .rawInsert("INSERT INTO images (image_data) VALUES (?)", [image]);

    for (final tag in tags) {
      final tagIdQuery = await _database!
          .rawQuery("SELECT tag_id FROM tags WHERE tag_name = ?", [tag]);
      var tagId = tagIdQuery.isNotEmpty ? tagIdQuery.first['tag_id'] : null;

      tagId ??= await _database!
          .rawInsert("INSERT INTO tags (tag_name) VALUES (?)", [tag]);

      await _database!.rawInsert(
          "INSERT INTO image_tags (image_id, tag_id) VALUES (?, ?)",
          [imageId, tagId]);
    }
  }
}

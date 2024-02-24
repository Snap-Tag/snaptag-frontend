import 'package:sqflite/sqflite.dart';
import 'package:snaptag_frontend/services/database/databaseservice.dart';
import 'package:snaptag_frontend/models/image.dart';

class TagsDB {
  Future<void> createTable(Database database) async {
    await database.execute(""" CREATE TABLE IF NOT EXIST image (
      imageID TEXT PRIMARY KEY,
      imagePath TEXT NOT NULL,
      PRIMARY KEY ("imageID" AUTOINCREMENT)
    );""");

    await database.execute(""" CREATE TABLE IF NOT EXIST tags (
      tagID TEXT PRIMARY KEY,
      tags TEXT NOT NULL,
      PRIMARY KEY ("tagID" AUTOINCREMENT)
    );""");

    await database.execute(""" CREATE TABLE IF NOT EXIST imageTags (
      imageID TEXT NOT NULL,
      tagID TEXT NOT NULL,
      FOREIGN KEY (imageID) REFERENCES image (imageID)),
      FOREIGN KEY (tagID) REFERENCES tags (tagID)),
      ON UPDATE SET NULL,
      ON DELETE SET NULL,
    );""");
  }

  Future<List<Image>> searchTags(String tag) async {
    // Database database = await DatabaseService().database;
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
  dynamic imagePaths = [];
  // Step 2: Use parameterized query to prevent SQL injection
  dynamic tagidResult = await database.rawQuery('SELECT tagID FROM tags WHERE tags = ?', [tag]);
  List tagidList = List.from(tagidResult);
  // Step 3: Check if tagid is not empty before proceeding with the next queries
  if (tagidList.isEmpty) {
    return []; // or handle the case when the tag doesn't exist
  }

  for(var tagid in tagidList)
  {
    // Step 4: Use proper column names and handle query results
  dynamic imageidResult = await database.rawQuery('SELECT imageID FROM imageTags WHERE tagID = ?', tagidList[tagid]);
  
  // Step 5: Check if there are no images for the given tag
  if (imageidResult.isEmpty) {
    return []; // or handle the case when there are no images for the given tag
  }

  // Step 6: Iterate through the result and retrieve image paths
  List imageidList = List.from(imageidResult);
  

  for (var entry in imageidList) {
    // Step 7: Use parameterized query to prevent SQL injection
    dynamic imagePathResult = await database.rawQuery('SELECT image_path FROM image WHERE imageID = ?', imageidList[entry]);
    
    // Step 8: Check if imagePathResult is not empty before extracting the path
    if (imagePathResult.isNotEmpty) {
      for(var imagepaths in imagePathResult){
        imagePaths.add(imagePathResult[imagepaths]);
      }
      
    }
  }
  }

  // Step 9: Create Image objects from the paths
  return imagePaths.map((path) => Image.fromSqfliteDatabase(path)).toList();
}

}

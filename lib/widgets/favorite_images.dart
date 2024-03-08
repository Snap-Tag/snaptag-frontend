import 'package:flutter/material.dart';
import 'package:snaptag_frontend/services/database/tags_db.dart';
import 'package:snaptag_frontend/widgets/imageslider.dart';

class FavoriteImages extends StatelessWidget {
  const FavoriteImages({super.key});

  @override
  Widget build(BuildContext context) {
    TagsDB tagsDB = TagsDB();
    return FutureBuilder(
        future: tagsDB.getFavoriteNotes(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            List<dynamic> favoriteImages = snapshot.data!;
            return snapshot.data!.isEmpty
                ? const Center(child: Text("No Favorite Images"))
                : ImageSlider(images: favoriteImages);
          } else {
            return const Placeholder();
          }
        }));
  }
}

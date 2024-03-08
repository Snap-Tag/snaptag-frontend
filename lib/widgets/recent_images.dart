import 'package:flutter/material.dart';
import 'package:snaptag_frontend/services/database/tags_db.dart';
import 'package:snaptag_frontend/widgets/imageslider.dart';

class RecentImages extends StatelessWidget {
  const RecentImages({super.key});

  @override
  Widget build(BuildContext context) {
    TagsDB tagsDB = TagsDB();
    return FutureBuilder(
      future: tagsDB.getRecentNotes(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          List<dynamic> recentImages = snapshot.data!;

          return recentImages.isEmpty
              ? const Center(child: Text("No Recent Images"))
              : ImageSlider(images: recentImages);
        } else {
          return const Placeholder();
        }
      },
    );
  }
}

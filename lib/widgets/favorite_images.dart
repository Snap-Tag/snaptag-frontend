import 'package:flutter/material.dart';
import 'package:snaptag_frontend/services/network.dart';
import 'package:snaptag_frontend/widgets/imageslider.dart';

class FavoriteImages extends StatelessWidget {
  const FavoriteImages({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SnapTagAPIRequest.getFavouriteNotes(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return snapshot.data!.isEmpty
                ? const Center(child: Text("No Favorite Images"))
                : ImageSlider(images: snapshot.data!);
          } else {
            return const Placeholder();
          }
        }));
  }
}

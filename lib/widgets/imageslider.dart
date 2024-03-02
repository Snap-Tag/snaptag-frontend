import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:snaptag_frontend/screens/notesPage.dart';

class ImageSlider extends StatelessWidget {
  final List<int> images;

  const ImageSlider({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 300.0, autoPlay: true),
      items: images.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotesPage(
                        imageData:
                            "https://codewithcurious.com/wp-content/uploads/2023/08/58-768x1089.png.webp"),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Card(
                  elevation: 3,
                  child: Image.network(
                    "https://codewithcurious.com/wp-content/uploads/2023/08/58-768x1089.png.webp",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

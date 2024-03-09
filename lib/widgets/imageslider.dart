import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:snaptag_frontend/models/imageModel.dart';
import 'package:snaptag_frontend/screens/notes_page.dart';

class ImageSlider extends StatelessWidget {
  final List<ImageModel> images;

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
                      builder: (context) => NotesPage(image: i),
                    ));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Card(
                  elevation: 3,
                  child: Image.memory(base64Decode(i.imageData),
                      fit: BoxFit.contain),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

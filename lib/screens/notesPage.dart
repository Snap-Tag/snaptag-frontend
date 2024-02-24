import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class NotesPage extends StatelessWidget {
  final String imageUrl;

  const NotesPage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: const NetworkImage(
          "https://codewithcurious.com/wp-content/uploads/2023/08/58-768x1089.png.webp"),
      minScale: PhotoViewComputedScale.contained * 0.8,
      maxScale: PhotoViewComputedScale.covered * 2,
    );
  }
}

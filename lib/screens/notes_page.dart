import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class NotesPage extends StatelessWidget {
  final Uint8List imageData;

  const NotesPage({required this.imageData});

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: MemoryImage(imageData),
      minScale: PhotoViewComputedScale.contained * 0.8,
      maxScale: PhotoViewComputedScale.covered * 2,
    );
  }
}

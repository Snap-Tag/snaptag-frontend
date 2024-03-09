import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:snaptag_frontend/models/imageModel.dart';
import 'package:snaptag_frontend/screens/done_page.dart';
import 'package:snaptag_frontend/services/network.dart';

class NotesPage extends StatefulWidget {
  final ImageModel image;

  const NotesPage({super.key, required this.image});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  bool _showAppBar = true;
  late bool _favorite;

  @override
  void initState() {
    super.initState();
    _favorite = widget.image.favorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showAppBar
          ? AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirmation'),
                            content: const Text(
                                'Are you sure you want to delete this image?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  SnapTagAPIRequest.deleteNote(
                                      widget.image.imageID);
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => const DonePage()),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                child: const Text('Confirm'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.delete)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _favorite = _favorite ? false : true;
                        SnackBar snackBar = SnackBar(
                          content: Text(_favorite
                              ? 'Added to Favorites'
                              : 'Removed from Favorites'),
                          duration: Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        SnapTagAPIRequest.setFavorite(
                            _favorite, widget.image.imageID);
                      });
                    },
                    icon: Icon(_favorite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined))
              ],
            )
          : AppBar(
              backgroundColor: Colors.transparent,
              toolbarHeight: 0,
            ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _showAppBar = _showAppBar ? false : true;
          });
        },
        child: PhotoView(
          imageProvider: MemoryImage(base64Decode(widget.image.imageData)),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2,
        ),
      ),
    );
  }
}

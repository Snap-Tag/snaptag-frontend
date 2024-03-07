import 'package:flutter/material.dart';
import 'package:snaptag_frontend/widgets/favorite_images.dart';
import 'package:snaptag_frontend/widgets/recent_images.dart';
import 'package:snaptag_frontend/widgets/searchbar.dart';
import 'package:snaptag_frontend/widgets/text_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 10),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SearchBarWidget(),
            TextWidget(text: "Recent Notes"),
            RecentImages(),
            TextWidget(text: "Favorites"),
            FavoriteImages()
          ],
        ),
      ),
    );
  }
}

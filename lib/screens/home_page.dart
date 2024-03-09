import 'package:flutter/material.dart';
import 'package:snaptag_frontend/widgets/favorite_images.dart';
import 'package:snaptag_frontend/widgets/recent_images.dart';
import 'package:snaptag_frontend/widgets/searchbar.dart';
import 'package:snaptag_frontend/widgets/text_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Key recentImagesKey = UniqueKey();
  Key favoriteImagesKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 10),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            recentImagesKey = UniqueKey();
            favoriteImagesKey = UniqueKey();
          });
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SearchBarWidget(),
              const TextWidget(text: "Recent Notes"),
              SizedBox(height: 300, child: RecentImages(key: recentImagesKey)),
              const TextWidget(text: "Favorites"),
              SizedBox(
                  height: 300, child: FavoriteImages(key: favoriteImagesKey)),
            ],
          ),
        ),
      ),
    );
  }
}

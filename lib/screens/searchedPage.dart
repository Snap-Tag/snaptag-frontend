import 'package:flutter/material.dart';
import 'package:snaptag_frontend/models/searchModel.dart';
import 'package:snaptag_frontend/screens/notesPage.dart';
import 'package:snaptag_frontend/services/network.dart';

class SearchedPage extends StatelessWidget {
  final String searchedString;
  const SearchedPage({required this.searchedString, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(searchedString)),
      body: FutureBuilder<searchModel>(
        future: SnapTagAPIRequest.getSearchImage(tags) ,
        itemCount: 5,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotesPage(
                        imageUrl:
                            "https://codewithcurious.com/wp-content/uploads/2023/08/58-768x1089.png.webp")), // Navigate to NotesPage
              );
            },
            child: SizedBox(
              height: 500,
              width: MediaQuery.of(context).size.width - 10,
              child: Card(
                child: Image.network(
                  "https://codewithcurious.com/wp-content/uploads/2023/08/58-768x1089.png.webp",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:snaptag_frontend/models/image.dart';
import 'package:snaptag_frontend/models/searchedModel.dart';
import 'package:snaptag_frontend/screens/notesPage.dart';
import 'package:snaptag_frontend/services/database/tags_db.dart';
import 'package:snaptag_frontend/services/network.dart';

class SearchedPage extends StatelessWidget {
  final String searchedString;
  const SearchedPage({required this.searchedString, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TagsDB tagsDB = TagsDB();
    return Scaffold(
      appBar: AppBar(title: Text(searchedString)),
      body: FutureBuilder(
          future: tagsDB.searchTags(searchedString),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              return snapshot.data!.isEmpty
                  ? const Center(child: Text("No data found"))
                  : ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotesPage(
                                      imageData:
                                          snapshot.data![index].imageData)),
                            );
                          },
                          child: SizedBox(
                            height: 500,
                            width: MediaQuery.of(context).size.width - 10,
                            child: Card(
                              child: Image.memory(
                                snapshot.data![index].imageData,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      },
                    );
            } else {
              return const Center(child: Text("No data found"));
            }
          }),
    );
  }
}

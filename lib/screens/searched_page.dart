import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:snaptag_frontend/models/imageModel.dart';
import 'package:snaptag_frontend/screens/notes_page.dart';
import 'package:snaptag_frontend/services/network.dart';

class SearchedPage extends StatelessWidget {
  final String searchedString;
  const SearchedPage({required this.searchedString, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(searchedString)),
      body: FutureBuilder<List<ImageModel>>(
          future: SnapTagAPIRequest.getSearchImage(searchedString),
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
                                  builder: (context) =>
                                      NotesPage(image: snapshot.data![index])),
                            );
                          },
                          child: SizedBox(
                            height: 500,
                            width: MediaQuery.of(context).size.width - 10,
                            child: Card(
                              child: Image.memory(
                                base64Decode(snapshot.data![index].imageData),
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

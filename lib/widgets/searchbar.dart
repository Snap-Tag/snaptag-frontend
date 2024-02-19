import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 40,
        child: const SearchBar(
          trailing: [
            Icon(Icons.search),
            SizedBox(
              width: 10,
            )
          ],
          hintText: "Search your handwritten notes",
        ),
      ),
    );
  }
}

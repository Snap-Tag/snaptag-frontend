import 'package:flutter/material.dart';
import 'package:snaptag_frontend/screens/searchedPage.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 40,
        child: SearchBar(
          trailing: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            const SizedBox(
              width: 10,
            )
          ],
          hintText: "Search your handwritten notes",
          onSubmitted: (value) {
            Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
              return SearchedPage(searchedString: value);
            })));
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:snaptag_frontend/constants/theme.dart';
import 'package:snaptag_frontend/widgets/searchbar.dart';
import 'package:snaptag_frontend/widgets/text_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 10),
      body: Column(children: [
        const SearchBarWidget(),
        const TextWidget(text: "Recent Notes"),
        Container(
          height: 250,
          color: ThemeColor.placeholder,
        ),
        const TextWidget(text: "Favorites"),
        Container(
          height: 250,
          color: ThemeColor.placeholder,
        )
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:snaptag_frontend/widgets/text_widget.dart';

final List<String> tags = [
  "Operation System",
  "Software",
  "Abstraction",
  "System Call"
];

class CapturedPage extends StatefulWidget {
  const CapturedPage({super.key});

  @override
  State<CapturedPage> createState() => _CapturedPageState();
}

class _CapturedPageState extends State<CapturedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 400,
            width: MediaQuery.of(context).size.width - 50,
            child: Card(
                child: Image.network(
              "https://codewithcurious.com/wp-content/uploads/2023/08/58-768x1089.png.webp",
              fit: BoxFit.contain,
            )),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextWidget(text: "Tags"),
            IconButton(onPressed: () {}, icon: const Icon(Icons.add))
          ],
        ),
        SizedBox(
          height: 190,
          width: 250,
          child: ListView.builder(
            itemCount: tags.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(tags[index]),
                trailing: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.remove)),
              );
            },
          ),
        ),
      ]),
    );
  }
}

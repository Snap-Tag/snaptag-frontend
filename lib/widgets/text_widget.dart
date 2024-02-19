import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  const TextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const SizedBox(
              width: 30,
            ),
            Text(text,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

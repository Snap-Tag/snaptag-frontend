import 'package:flutter/material.dart';

class UploadDone extends StatelessWidget {
  const UploadDone({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: Column(
      children: [Icon(Icons.check), Text("Done")],
    )));
  }
}

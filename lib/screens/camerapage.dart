import 'package:flutter/material.dart';
import 'package:snaptag_frontend/screens/capturedpage.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            child: const Text("Capture Me"),
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CapturedPage()))),
      ),
    );
  }
}

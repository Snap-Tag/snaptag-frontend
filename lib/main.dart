import 'package:flutter/material.dart';
import 'package:snaptag_frontend/screens/camerapage.dart';
import 'package:snaptag_frontend/widgets/dashboard.dart';

void main() {
  runApp(const SnapTag());
}

class SnapTag extends StatelessWidget {
  const SnapTag({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => const Dashboard(),
        "/camera": (context) => const CameraPage()
      },
      theme: ThemeData(fontFamily: "Inter"),
    );
  }
}

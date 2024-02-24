import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:snaptag_frontend/screens/camerapage.dart';
import 'package:snaptag_frontend/widgets/dashboard.dart';

late CameraDescription firstCamera;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  firstCamera = cameras.first;
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

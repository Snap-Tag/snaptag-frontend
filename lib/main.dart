import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snaptag_frontend/providers/tags_provider.dart';
import 'package:snaptag_frontend/screens/camera_page.dart';
import 'package:snaptag_frontend/widgets/dashboard.dart';

late CameraDescription firstCamera;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  firstCamera = cameras.first;
  runApp(
    const SnapTag(),
  );
}

class SnapTag extends StatelessWidget {
  const SnapTag({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => TagsProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          routes: {
            "/": (context) => const Dashboard(),
            "/camera": (context) => const CameraPage(),
          },
          theme: ThemeData(fontFamily: "Inter"),
        ));
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snaptag_frontend/providers/tagsProvider.dart';
import 'package:snaptag_frontend/screens/camerapage.dart';
import 'package:snaptag_frontend/widgets/dashboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

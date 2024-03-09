import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:snaptag_frontend/main.dart';
import 'package:snaptag_frontend/screens/captured_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.ultraHigh,
    );
    _controller.setFlashMode(FlashMode.off);

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Capture Notes")),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.camera_alt, size: 45),
            onPressed: () async {
              try {
                await _initializeControllerFuture;
                final image = await _controller.takePicture();

                if (!mounted) return;

                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CapturedPage(imagePath: image.path),
                  ),
                );
              } catch (e) {
                print(e);
              }
            },
          ),
        ],
      ),
    );
  }
}

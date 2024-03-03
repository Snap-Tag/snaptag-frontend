import 'package:flutter/material.dart';

class UploadDone extends StatelessWidget {
  const UploadDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check, size: 48),
            const SizedBox(height: 16),
            Text("Done", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Navigate to Dashboard using named route "/"
                Navigator.pushNamed(context, "/");
              },
              child: Text("Go to Dashboard"),
            ),
          ],
        ),
      ),
    );
  }
}

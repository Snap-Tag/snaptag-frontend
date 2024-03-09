import 'package:flutter/material.dart';

class DonePage extends StatelessWidget {
  const DonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check, size: 48),
            const SizedBox(height: 16),
            const Text("Done", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Navigate to Dashboard using named route "/"
                Navigator.pushNamedAndRemoveUntil(
                    context, "/", ((Route<dynamic> route) => false));
              },
              child: const Text("Go to Dashboard"),
            ),
          ],
        ),
      ),
    );
  }
}

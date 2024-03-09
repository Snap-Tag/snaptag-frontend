import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('About Us'),
        ),
        body: const Column(
          children: [
            Text(
              'Members:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('1. John Doe - Roll No. 001'),
            Text('2. Jane Smith - Roll No. 002'),
            Text('3. Alex Johnson - Roll No. 003'),
            Text('4. Sarah Williams - Roll No. 004'),
            SizedBox(height: 20),
            Text(
              'Objective of SnapTag: CTRL + F for Handwritten Notes',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ));
  }
}

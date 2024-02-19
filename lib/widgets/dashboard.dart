import 'package:flutter/material.dart';
import 'package:snaptag_frontend/constants/theme.dart';
import 'package:snaptag_frontend/screens/camerapage.dart';
import 'package:snaptag_frontend/screens/homepage.dart';
import 'package:snaptag_frontend/screens/profilepage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentPage = 0; // default display page is home page
  final int cameraScreen = 2; // index of camera page in screens list

  List<Widget> screens = [
    const HomePage(),
    const ProfilePage(),
    const CameraPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeColor.background,
        elevation: 30,
        shape: const CircleBorder(),
        onPressed: () => Navigator.of(context).pushNamed("/camera"),
        child:
            const Icon(Icons.camera, color: ThemeColor.buttonColor, size: 55),
      ),
      body: screens[currentPage],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPage,
          fixedColor: ThemeColor.buttonColor,
          unselectedItemColor: ThemeColor.background,
          backgroundColor: ThemeColor.navbar,
          type: BottomNavigationBarType.fixed,
          onTap: (value) => setState(() {
                currentPage = value;
              }),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
          ]),
    );
  }
}

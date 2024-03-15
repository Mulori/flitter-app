import 'package:flitter/pages/home_page.dart';
import 'package:flitter/pages/login_page.dart';
import 'package:flitter/pages/user_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // ignore: unused_field
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        title: const Text("Flitter"),
      ),
      body: HomePage(),
    );
  }
}

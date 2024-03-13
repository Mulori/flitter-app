import 'package:flitter/pages/home_page.dart';
import 'package:flitter/pages/login_page.dart';
import 'package:flitter/pages/product_page.dart';
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
      body: _PageManagement(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _currentIndex == 0 ? Colors.amber[400] : Colors.black,
            ),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.file_open,
              color: _currentIndex == 1 ? Colors.amber[400] : Colors.black,
            ),
            label: 'Cadastros',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _currentIndex == 2 ? Colors.amber[400] : Colors.black,
            ),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

Widget _PageManagement(int pagina) {
  // Coloque o conteúdo específico da guia "Pesquisar" aqui
  switch (pagina) {
    case 0:
      return HomePage();
    case 1:
      return ProductPage();
    case 2:
      return UserPage();
    default:
      return LoginPage();
  }
}

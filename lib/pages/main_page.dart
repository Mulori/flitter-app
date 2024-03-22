import 'package:flitter/pages/home_page.dart';
import 'package:flitter/pages/register_page.dart';
import 'package:flitter/pages/sale_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

List<String> pages = ["Cadastros", "Vendas", "Relatórios", "Minha Empresa"];

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width - 20,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 255, 202, 40)),
                accountName: Text("Conta de Testes",
                    style: TextStyle(color: Colors.black)),
                accountEmail: Text("conta.teste@flitter.com.br",
                    style: TextStyle(color: Colors.black))),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(
                Icons.widgets,
                color: Colors.black,
              ),
              title: const Text(
                "Cadastros",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RegisterPage()))
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.local_grocery_store,
                color: Colors.black,
              ),
              title: const Text(
                "Pedidos",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              onTap: () => {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SalePage()))
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        title: Align(
          alignment: const FractionalOffset(1, 0),
          child: Image.asset(
            "assets/image/logo.png",
            height: 30,
            alignment: const FractionalOffset(0, 0.5),
            width: 100,
          ),
        ),
      ),
      body: const HomePage(),
    );
  }
}

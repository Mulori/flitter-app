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
        width: MediaQuery.of(context).size.width,
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
                color: Color.fromARGB(255, 255, 202, 40),
              ),
              title: const Text(
                "Cadastros",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 202, 40)),
              ),
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RegisterPage()))
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(
                Icons.local_grocery_store,
                color: Color.fromARGB(255, 255, 202, 40),
              ),
              title: const Text(
                "Vendas",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 202, 40)),
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
        title: const Text("Flitter"),
      ),
      body: const HomePage(),
    );
  }
}

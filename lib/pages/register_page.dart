import 'package:flitter/pages/brand_page.dart';
import 'package:flitter/pages/group_page.dart';
import 'package:flitter/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        title: const Text("Cadastros"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const ProductPage()));
                              },
                              child: const Column(
                                children: [
                                  Icon(Icons.widgets),
                                  Text("Produtos"),
                                ],
                              ))),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const BrandPage()));
                              },
                              child: const Column(
                                children: [
                                  Icon(Icons.local_offer),
                                  Text("Marcas"),
                                ],
                              ))),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const GroupPage()));
                              },
                              child: const Column(
                                children: [
                                  Icon(Icons.layers),
                                  Text("Grupos"),
                                ],
                              )))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

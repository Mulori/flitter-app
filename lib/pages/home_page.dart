import 'package:flitter/pages/brand_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flitter/pages/product_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: InkWell(
                          onTap: () => {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const ProductPage()))
                              },
                          splashColor: Colors.amber.withOpacity(
                              0.5), // Cor da animação de pressionar
                          highlightColor: Colors.amber.withOpacity(
                              0.2), // Cor de destaque durante o toque
                          borderRadius: BorderRadius.circular(
                              10.0), // Raio da borda desejado
                          child: Container(
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Icon(Icons.widgets),
                                  Text("Meus Produtos"),
                                ],
                              ),
                            ),
                          ))),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      flex: 1,
                      child: InkWell(
                          onTap: () => {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const BrandPage()))
                              },
                          splashColor: Colors.amber.withOpacity(
                              0.5), // Cor da animação de pressionar
                          highlightColor: Colors.amber.withOpacity(
                              0.2), // Cor de destaque durante o toque
                          borderRadius: BorderRadius.circular(
                              10.0), // Raio da borda desejado
                          child: Container(
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Icon(Icons.bookmark),
                                  Text("Marcas"),
                                ],
                              ),
                            ),
                          ))),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: InkWell(
                          onTap: () => {print("meus produtos")},
                          splashColor: Colors.amber.withOpacity(
                              0.5), // Cor da animação de pressionar
                          highlightColor: Colors.amber.withOpacity(
                              0.2), // Cor de destaque durante o toque
                          borderRadius: BorderRadius.circular(
                              10.0), // Raio da borda desejado
                          child: Container(
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Icon(Icons.bookmark_outline_sharp),
                                  Text("Minhas Vendas"),
                                ],
                              ),
                            ),
                          ))),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      flex: 1,
                      child: InkWell(
                          onTap: () => {print("meus produtos")},
                          splashColor: Colors.amber.withOpacity(
                              0.5), // Cor da animação de pressionar
                          highlightColor: Colors.amber.withOpacity(
                              0.2), // Cor de destaque durante o toque
                          borderRadius: BorderRadius.circular(
                              10.0), // Raio da borda desejado
                          child: Container(
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Icon(Icons.attach_money),
                                  Text("Financeiro"),
                                ],
                              ),
                            ),
                          ))),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

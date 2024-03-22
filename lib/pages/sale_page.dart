import 'package:flitter/pages/detail_sale_page.dart';
import 'package:flutter/material.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        title: const Text("Pedidos"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[400],
        onPressed: () => {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const DetailSalePage()))
        },
        child: const Icon(Icons.add_box),
      ),
    );
  }
}

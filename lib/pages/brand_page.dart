import 'package:flitter/models/brand_model.dart';
import 'package:flitter/pages/new_brand_page.dart';
import 'package:flitter/repositories/Entity/brand.dart';
import 'package:flutter/material.dart';

class BrandPage extends StatefulWidget {
  const BrandPage({super.key});

  @override
  State<BrandPage> createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  List<BrandModel> lista = [];

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  Future<void> _refreshList() async {
    await getBrand().then((value) => {
          setState(() {
            lista = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        title: const Text("Marcas"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[400],
        onPressed: () => {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const NewBrandPage()))
        },
        child: const Icon(Icons.add_box),
      ),
      body: RefreshIndicator(
        color: Colors.amber[400],
        onRefresh: _refreshList,
        child: ListView.builder(
            itemCount: lista.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  title: Text('#' +
                      lista[index].id.toString() +
                      ' ' +
                      lista[index].nomeMarca));
            }),
      ),
    );
  }
}

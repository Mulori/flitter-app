import 'package:flitter/components/imageCustom.dart';
import 'package:flitter/models/product_model.dart';
import 'package:flitter/pages/edit_product_page.dart';
import 'package:flitter/pages/new_product_page.dart';
import 'package:flitter/repositories/Entity/product.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ProductModel> lista = [];

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  Future<void> _refreshList() async {
    await getProdutos().then((value) => {
          setState(() {
            lista = value;
          })
        });
  }

  String formatarMoeda(double valor) {
    return 'R\$ ${valor.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {},
              child: const Icon(Icons.search),
            ),
          )
        ],
        backgroundColor: Colors.amber[400],
        title: const Text("Produtos"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[400],
        onPressed: () => {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const NewProductPage()))
        },
        child: const Icon(Icons.add_box),
      ),
      body: RefreshIndicator(
        color: Colors.amber[400],
        onRefresh: _refreshList,
        child: ListView.builder(
            itemCount: lista.length,
            itemBuilder: (BuildContext context, int index) {
              var subtitle =
                  'Estoque: ${lista[index].estoqueProduto}    ${formatarMoeda(lista[index].valorDeVenda)}';
              return InkWell(
                onTap: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          EditProductPage(produtoSelecionado: lista[index])))
                },
                child: ListTile(
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CustomImage(
                            tipo: lista[index].tipoImagem,
                            caminho: lista[index].caminhoImagem)),
                    title: Text(
                        '#${lista[index].id} ${lista[index].tituloDoProduto}'),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            Text(subtitle.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Cód: ${lista[index].codigoDeBarras}"),
                          ],
                        ),
                      ],
                    )),
              );
            }),
      ),
    );
  }
}

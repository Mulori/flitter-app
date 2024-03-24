import 'package:flitter/models/item_sale_model.dart';
import 'package:flitter/repositories/Entity/item_sale.dart';
import 'package:flutter/material.dart';

class CartSalePage extends StatefulWidget {
  final int idVenda;

  const CartSalePage({super.key, required this.idVenda});

  @override
  State<CartSalePage> createState() => _CartSalePageState();
}

class _CartSalePageState extends State<CartSalePage> {
  int idVenda = 0;
  List<ItemSaleModel> listaProdutos = [];

  @override
  void initState() {
    super.initState();
    idVenda = widget.idVenda;
    _refreshList();
  }

  Future<void> _refreshList() async {
    await getItensBySale(idVenda).then((value) => {
          setState(() {
            listaProdutos = value;
          })
        });
  }

  void removeOne(int id) async {
    var item = await getItensById(id);

    if (item.isEmpty) {
      return;
    }

    if ((item[0].quantidade - 1) <= 0) {
      deleteItem(id);
    } else {
      updateItemQtde(id, item[0].quantidade - 1);
    }

    _refreshList();
  }

  void addOne(int id) async {
    var item = await getItensById(id);

    if (item.isEmpty) {
      return;
    }

    updateItemQtde(id, item[0].quantidade + 1);

    _refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          InkWell(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(Icons.done),
            ),
          )
        ],
        backgroundColor: Colors.amber[400],
        title: Text("Carrinho # $idVenda"),
      ),
      body: RefreshIndicator(
        color: Colors.amber[400],
        onRefresh: _refreshList,
        child: ListView.builder(
            itemCount: listaProdutos.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: InkWell(
                    onTap: () => {addOne(listaProdutos[index].id)},
                    child: const Icon(Icons.exposure_plus_1)),
                trailing: InkWell(
                    onTap: () => {removeOne(listaProdutos[index].id)},
                    child: const Icon(Icons.exposure_minus_1)),
                title: Text(listaProdutos[index].tituloProduto),
                subtitle: Text(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    'Qtde: ${listaProdutos[index].quantidade.toString()}  Preço: ${listaProdutos[index].preco.toString()}  Total: ${listaProdutos[index].valorTotal.toString()}'),
              );
            }),
      ),
    );
  }
}

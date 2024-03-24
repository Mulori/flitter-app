import 'dart:io';

import 'package:flitter/components/toast.dart';
import 'package:flitter/models/item_sale_model.dart';
import 'package:flitter/pages/cart_sale.dart';
import 'package:flitter/repositories/Entity/item_sale.dart';
import 'package:flutter/material.dart';
import 'package:flitter/models/group_model.dart';
import 'package:flitter/models/product_model.dart';
import 'package:flitter/repositories/Entity/group.dart';
import 'package:flitter/repositories/Entity/product.dart';
import 'package:toastification/toastification.dart';

class DetailSalePage extends StatefulWidget {
  final int idVenda;

  const DetailSalePage({Key? key, required this.idVenda}) : super(key: key);

  @override
  State<DetailSalePage> createState() => _DetailSalePageState();
}

class _DetailSalePageState extends State<DetailSalePage> {
  int _idVenda = 0;
  List<GroupModel> listaGrupo = [];
  List<ProductModel> listaProduto = [];
  GroupModel? grupoSelecionado;

  @override
  void initState() {
    super.initState();
    _idVenda = widget.idVenda;
    carregaListaGrupo();
  }

  Future<void> carregaListaGrupo() async {
    await getGroup().then((value) async {
      setState(() {
        listaGrupo = value;

        if (value.isNotEmpty) {
          grupoSelecionado = value[0];

          int id = grupoSelecionado?.id ?? 0;

          carregaListaProduto(id);
        }
      });
    });
  }

  Future<void> carregaListaProduto(int grupo) async {
    await getProdutoByGrupo(grupo).then((value) {
      setState(() {
        listaProduto = value;
      });
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
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CartSalePage(idVenda: _idVenda)))
              },
              child: const Icon(Icons.local_grocery_store),
            ),
          )
        ],
        backgroundColor: Colors.amber[400],
        title: Text("Adicionar Itens #$_idVenda"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listaGrupo.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor:
                            grupoSelecionado?.id == listaGrupo[index].id
                                ? Color.fromARGB(255, 230, 155, 17)
                                : Colors.amber[400],
                      ),
                      onPressed: () async {
                        setState(() {
                          grupoSelecionado = listaGrupo[index];
                        });
                        await carregaListaProduto(listaGrupo[index].id);
                      },
                      child: Align(
                        alignment: FractionalOffset.center,
                        child: Text(
                          listaGrupo[index].nomeGrupo,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: listaProduto.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return NewItemSaleDialog(
                            idVenda: _idVenda,
                            idProduto: listaProduto[index].id,
                            preco: listaProduto[index].valorDeVenda);
                      },
                    )
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.file(
                          File(listaProduto[index].caminhoImagem),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          listaProduto[index].tituloDoProduto,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'R\$ ${listaProduto[index].valorDeVenda.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NewItemSaleDialog extends StatefulWidget {
  final int idVenda;
  final int idProduto;
  final double preco;

  const NewItemSaleDialog(
      {Key? key,
      required this.idVenda,
      required this.idProduto,
      required this.preco})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NewItemSaleState createState() => _NewItemSaleState();
}

class _NewItemSaleState extends State<NewItemSaleDialog> {
  int idVenda = 0;
  int idProduto = 0;
  double preco = 0;
  final TextEditingController quantidadeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    quantidadeController.text = "1";
    idVenda = widget.idVenda;
    idProduto = widget.idProduto;
    preco = widget.preco;
  }

  void novaVenda() async {
    if (quantidadeController.text.isEmpty) {
      showToast(
          context, "Atenção", "Informe a quantidade", ToastificationType.error);
      return;
    }

    ItemSaleModel venda = ItemSaleModel(
      id: 0,
      vendaId: idVenda,
      produtoId: idProduto,
      status: 'P',
      tituloProduto: '',
      preco: preco,
      quantidade: double.parse(quantidadeController.text),
      desconto: 0,
      valorTotal: preco * double.parse(quantidadeController.text),
      dataHoraCriacao: DateTime.now(),
      dataHoraModificacao: DateTime.now(),
      dataHoraSincronizacao: DateTime(2000, 1, 1),
    );

    var id = await createItemSale(venda);

    Navigator.of(context).pop();

    showToast(context, "Produto Adicionado", "O item foi incluido no carrinho",
        ToastificationType.success);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Item'),
      content: const Text('Informe a quantidade abaixo'),
      actions: <Widget>[
        Column(
          children: [
            const Align(
                alignment: FractionalOffset.centerLeft,
                child: Text("Quantidade: *")),
            TextField(
              controller: quantidadeController,
              maxLength: 50,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Ex: 1',
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () => novaVenda(),
                  child: const Text("Adicionar"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flitter/models/product_model.dart';
import 'package:flitter/models/brand_model.dart';
import 'package:flitter/repositories/Entity/brand.dart';
import 'package:flutter/material.dart';
import 'package:flitter/repositories/Entity/product.dart';

class NewProductPage extends StatefulWidget {
  const NewProductPage({super.key});

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController barrasController = TextEditingController();
  final TextEditingController valorCompraController = TextEditingController();
  final TextEditingController valorVendaController = TextEditingController();
  final TextEditingController estoqueController = TextEditingController();
  final TextEditingController marcaController = TextEditingController();

  BrandModel? marcaSelecionada;
  List<BrandModel> listaMarca = [];

  @override
  void initState() {
    super.initState();
    carregaListaMarca();
  }

  Future<void> carregaListaMarca() async {
    await getBrand().then((value) => {
          setState(() {
            listaMarca = value;

            if (value.isNotEmpty) {
              marcaSelecionada = value[0];
            }
          })
        });
  }

  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {},
  );

  void salvar() {
    if (tituloController.text.isEmpty ||
        barrasController.text.isEmpty ||
        valorCompraController.text.isEmpty ||
        valorVendaController.text.isEmpty) {
      var alert = AlertDialog(
        title: const Text("Atenção"),
        content: const Text("Por Favor, preencha todos os campos!"),
        actions: [
          okButton,
        ],
      );

      return;
    }

    int marcaId = marcaSelecionada?.id ?? 0;

    ProductModel produto = ProductModel(
        id: 0,
        codigoDeBarras: barrasController.text.trim(),
        tituloDoProduto: tituloController.text.trim(),
        valorDeCusto: double.tryParse(valorCompraController.text) ?? 0,
        valorDeVenda: double.tryParse(valorVendaController.text) ?? 0,
        dataHoraCriacao: DateTime.now(),
        marca: marcaId,
        estoqueProduto: double.tryParse(estoqueController.text) ?? 0,
        dataHoraModificacao: DateTime.now(),
        dataHoraSincronizacao: DateTime(2000, 1, 1));

    createProduct(produto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        title: const Text("Novo Produto"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[400],
        onPressed: () => {salvar()},
        child: Icon(Icons.save),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: tituloController,
                maxLength: 50,
                decoration: const InputDecoration(
                  labelText: 'Titulo',
                  hintText: 'Ex: Sapato Tamanho 12',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: barrasController,
                maxLength: 13,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Código de Barras',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: valorCompraController,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Valor de Compra',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: valorVendaController,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Valor de Venda',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: estoqueController,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Estoque',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                  border: Border.all(
                      color: Colors.black54,
                      style: BorderStyle.solid,
                      width: 0.80),
                ),
                child: DropdownButtonHideUnderline(
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: DropdownButton<BrandModel>(
                      isDense: true,
                      isExpanded: true,
                      value: marcaSelecionada,
                      items: listaMarca.map((BrandModel marca) {
                        return DropdownMenuItem<BrandModel>(
                          value: marca,
                          child: Text(marca.nomeMarca), // Texto exibido
                        );
                      }).toList(),
                      onChanged: (BrandModel? novaMarcaSelecionada) {
                        setState(() {
                          marcaSelecionada = novaMarcaSelecionada;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

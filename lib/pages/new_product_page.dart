import 'dart:io';

import 'package:flitter/components/toast.dart';
import 'package:flitter/models/group_model.dart';
import 'package:flitter/models/product_model.dart';
import 'package:flitter/models/brand_model.dart';
import 'package:flitter/repositories/Entity/brand.dart';
import 'package:flitter/repositories/Entity/group.dart';
import 'package:flutter/material.dart';
import 'package:flitter/repositories/Entity/product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

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

  BrandModel? marcaSelecionada;
  GroupModel? grupoSelecionado;
  List<BrandModel> listaMarca = [];
  List<GroupModel> listaGrupo = [];
  File? imagem;
  String caminhoImagem = '';

  void limparCampos() {
    tituloController.text = "";
    barrasController.text = "";
    valorCompraController.text = "";
    valorVendaController.text = "";
    estoqueController.text = "";
    imagem = null;
    caminhoImagem = "";
  }

  Future<void> getImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        imagem = File(pickedImage.path);
        caminhoImagem = pickedImage.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    carregaListaMarca();
    carregaListaGrupo();
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

  Future<void> carregaListaGrupo() async {
    await getGroup().then((value) => {
          setState(() {
            listaGrupo = value;

            if (value.isNotEmpty) {
              grupoSelecionado = value[0];
            }
          })
        });
  }

  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {},
  );

  void salvar() async {
    if (tituloController.text.isEmpty ||
        valorCompraController.text.isEmpty ||
        estoqueController.text.isEmpty ||
        valorVendaController.text.isEmpty) {
      showToast(context, "Ops... Algo deu errado!",
          "Preencha todos os campos obrigatórios.", ToastificationType.warning);
      return;
    }

    if (barrasController.text.isNotEmpty) {
      var produto = await getProdutoByEAN(barrasController.text);

      if (produto.isNotEmpty) {
        showToast(
            // ignore: use_build_context_synchronously
            context,
            "Código de barras em uso.",
            "Já existe um produto cadastrado com este código de barras.",
            ToastificationType.warning);
        return;
      }
    }

    int marcaId = marcaSelecionada?.id ?? 0;
    int grupoId = grupoSelecionado?.id ?? 0;

    ProductModel produto = ProductModel(
        id: 0,
        codigoDeBarras: barrasController.text.trim(),
        tituloDoProduto: tituloController.text.trim(),
        valorDeCusto: double.tryParse(valorCompraController.text) ?? 0,
        valorDeVenda: double.tryParse(valorVendaController.text) ?? 0,
        dataHoraCriacao: DateTime.now(),
        marca: marcaId,
        grupo: grupoId,
        tipoImagem: caminhoImagem.isNotEmpty ? 1 : 0,
        caminhoImagem: caminhoImagem,
        estoqueProduto: double.tryParse(estoqueController.text) ?? 0,
        dataHoraModificacao: DateTime.now(),
        dataHoraSincronizacao: DateTime(2000, 1, 1));

    createProduct(produto);
    limparCampos();

    showToast(context, "Sucesso", "O produto foi inserido com sucesso!",
        ToastificationType.success);
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
        child: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (imagem != null)
                Image.file(
                  imagem!,
                  width: 200,
                  height: 200,
                ),
              InkWell(
                onTap: getImage,
                child: const Column(
                  children: [
                    Icon(Icons.local_see),
                    Text('Tirar foto do produto'),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                  alignment: FractionalOffset.centerLeft,
                  child: Text("Titulo do produto: *")),
              TextField(
                controller: tituloController,
                maxLength: 50,
                decoration: const InputDecoration(
                  hintText: 'Ex: Prato',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                  alignment: FractionalOffset.centerLeft,
                  child: Text("Código de Barras:")),
              TextField(
                  controller: barrasController,
                  maxLength: 13,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(hintText: "Ex: 7894561234569")),
              const SizedBox(
                height: 15,
              ),
              const Align(
                  alignment: FractionalOffset.centerLeft,
                  child: Text("Valor de Custo: *")),
              TextField(
                controller: valorCompraController,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Ex: 10,00",
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: FractionalOffset.centerLeft,
                child: Text("Valor de Venda: *"),
              ),
              TextField(
                controller: valorVendaController,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Ex: 20,00',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: FractionalOffset.centerLeft,
                child: Text("Estoque Atual: *"),
              ),
              TextField(
                controller: estoqueController,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Ex: 100',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: FractionalOffset.centerLeft,
                child: Text("Selecione a Marca:"),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButtonHideUnderline(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
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
              const Align(
                alignment: FractionalOffset.centerLeft,
                child: Text("Selecione o Grupo:"),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButtonHideUnderline(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DropdownButton<GroupModel>(
                      isDense: true,
                      isExpanded: true,
                      value: grupoSelecionado,
                      items: listaGrupo.map((GroupModel grupo) {
                        return DropdownMenuItem<GroupModel>(
                          value: grupo,
                          child: Text(grupo.nomeGrupo), // Texto exibido
                        );
                      }).toList(),
                      onChanged: (GroupModel? novaGrupoaSelecionada) {
                        setState(() {
                          grupoSelecionado = novaGrupoaSelecionada;
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

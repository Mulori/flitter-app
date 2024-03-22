import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
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

class EditProductPage extends StatefulWidget {
  final ProductModel produtoSelecionado;

  const EditProductPage({super.key, required this.produtoSelecionado});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late ProductModel _ProdutoSelecionado;

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
      CroppedFile imagemCortada = await cortarImagem(File(pickedImage.path));
      setState(() {
        imagem = File(imagemCortada.path);
        caminhoImagem = imagemCortada.path;
      });
    }
  }

  Future<void> getImageGalery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      CroppedFile imagemCortada = await cortarImagem(File(pickedImage.path));

      setState(() {
        imagem = File(imagemCortada.path);
        caminhoImagem = imagemCortada.path;
      });
    }
  }

  cortarImagem(File imagem) async {
    return await ImageCropper().cropImage(
        sourcePath: imagem.path,
        compressFormat: ImageCompressFormat.png,
        compressQuality: 70,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: "Cortar Imagem",
              toolbarColor: Colors.amber[400],
              initAspectRatio: CropAspectRatioPreset.square),
          IOSUiSettings(
            title: "Cortar Imagem",
          )
        ]);
  }

  @override
  void initState() {
    super.initState();
    carregaListaMarca();
    carregaListaGrupo();

    setState(() {
      _ProdutoSelecionado = widget.produtoSelecionado;
      carregaCampos();
    });
  }

  void carregaCampos() {
    tituloController.text = _ProdutoSelecionado.tituloDoProduto;
    barrasController.text = _ProdutoSelecionado.codigoDeBarras;
    valorCompraController.text = _ProdutoSelecionado.valorDeCusto.toString();
    valorVendaController.text = _ProdutoSelecionado.valorDeVenda.toString();
    estoqueController.text = _ProdutoSelecionado.estoqueProduto.toString();
    caminhoImagem = _ProdutoSelecionado.caminhoImagem;
  }

  void definirDropDownSelecionadoPeloId(int id, int tipo) {
    switch (tipo) {
      case 1:
        BrandModel? marca = listaMarca.firstWhere((marca) => marca.id == id);
        setState(() {
          marcaSelecionada = marca;
        });
        break;
      case 2:
        GroupModel? grupo = listaGrupo.firstWhere((marca) => marca.id == id);
        setState(() {
          grupoSelecionado = grupo;
        });
        break;
    }
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

  void salvar() async {
    if (tituloController.text.isEmpty ||
        valorCompraController.text.isEmpty ||
        estoqueController.text.isEmpty ||
        barrasController.text.isEmpty ||
        valorVendaController.text.isEmpty) {
      showToast(context, "Ops... Algo deu errado!",
          "Preencha todos os campos obrigatórios.", ToastificationType.warning);
      return;
    }

    barrasController.text = barrasController.text.toString().padLeft(13, '0');

    var produtoExist =
        await getProdutoByEANID(barrasController.text, _ProdutoSelecionado.id);

    if (produtoExist.isNotEmpty) {
      showToast(
          // ignore: use_build_context_synchronously
          context,
          "Código de barras em uso.",
          "Já existe um produto cadastrado com este código de barras.",
          ToastificationType.warning);
      return;
    }

    int marcaId = marcaSelecionada?.id ?? 0;
    int grupoId = grupoSelecionado?.id ?? 0;

    ProductModel produto = ProductModel(
        id: _ProdutoSelecionado.id,
        codigoDeBarras: barrasController.text.trim(),
        tituloDoProduto: tituloController.text.trim(),
        valorDeCusto: double.tryParse(valorCompraController.text) ?? 0,
        valorDeVenda: double.tryParse(valorVendaController.text) ?? 0,
        dataHoraCriacao: _ProdutoSelecionado.dataHoraCriacao,
        marca: marcaId,
        grupo: grupoId,
        tipoImagem: caminhoImagem.isNotEmpty ? 1 : 0,
        caminhoImagem: caminhoImagem,
        estoqueProduto: double.tryParse(estoqueController.text) ?? 0,
        dataHoraModificacao: DateTime.now(),
        dataHoraSincronizacao: _ProdutoSelecionado.dataHoraSincronizacao);

    updateProduct(produto);
    limparCampos();

    showToast(context, "Sucesso", "O produto foi alterado com sucesso!",
        ToastificationType.success);

    Navigator.of(context).pop();
  }

  void excluir() {
    deleteProduct(_ProdutoSelecionado.id);
    showToast(context, "Sucesso", "O produto foi excluido com sucesso!",
        ToastificationType.success);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () => {excluir()},
              child: const Icon(Icons.delete_forever),
            ),
          )
        ],
        backgroundColor: Colors.amber[400],
        title: const Text("Editar Produto"),
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
              if (caminhoImagem.isNotEmpty)
                Image.asset(
                  caminhoImagem,
                  width: 200,
                  height: 200,
                ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: getImageGalery,
                      child: const Column(
                        children: [
                          Icon(Icons.collections),
                          Text('Usar foto da galeria'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: getImage,
                      child: const Column(
                        children: [
                          Icon(Icons.local_see),
                          Text('Tirar foto do produto'),
                        ],
                      ),
                    ),
                  ),
                ],
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

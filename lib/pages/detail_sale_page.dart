import 'package:flitter/components/imageCustom.dart';
import 'package:flitter/models/group_model.dart';
import 'package:flitter/models/product_model.dart';
import 'package:flitter/repositories/Entity/group.dart';
import 'package:flitter/repositories/Entity/product.dart';
import 'package:flutter/material.dart';

class DetailSalePage extends StatefulWidget {
  const DetailSalePage({super.key});

  @override
  State<DetailSalePage> createState() => _DetailSalePageState();
}

class _DetailSalePageState extends State<DetailSalePage> {
  List<GroupModel> listaGrupo = [];
  List<ProductModel> listaProduto = [];
  GroupModel? grupoSelecionado;

  @override
  void initState() {
    super.initState();

    carregaListaGrupo();
  }

  Future<void> carregaListaGrupo() async {
    await getGroup().then((value) async => {
          setState(() {
            listaGrupo = value;

            if (value.isNotEmpty) {
              grupoSelecionado = value[0];

              int id = grupoSelecionado?.id ?? 0;

              carregaListaProduto(id);
            }
          })
        });
  }

  Future<void> carregaListaProduto(int grupo) async {
    await getProdutoByGrupo(grupo).then((value) => {
          setState(() {
            listaProduto = value;
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
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () => {},
              child: const Icon(Icons.local_grocery_store),
            ),
          )
        ],
        backgroundColor: Colors.amber[400],
        title: const Text("Adicionar Itens"),
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
                                ? const Color.fromARGB(255, 255, 166, 0)
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
          Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Define o número de colunas
                ),
                itemCount: listaProduto.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => {},
                            child: Column(
                              children: [
                                Align(
                                  alignment: FractionalOffset.center,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CustomImage(
                                          tipo: listaProduto[index].tipoImagem,
                                          caminho: listaProduto[index]
                                              .caminhoImagem)),
                                ),
                                Align(
                                  alignment: FractionalOffset.center,
                                  child: Text(
                                    listaProduto[index].tituloDoProduto.length >
                                            45
                                        ? "${listaProduto[index].tituloDoProduto.substring(0, 45)}..."
                                        : listaProduto[index].tituloDoProduto,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Align(
                                  alignment: FractionalOffset.center,
                                  child: Text(
                                    formatarMoeda(
                                        listaProduto[index].valorDeVenda),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

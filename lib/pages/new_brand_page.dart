import 'package:flitter/components/toast.dart';
import 'package:flitter/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:flitter/repositories/Entity/brand.dart';
import 'package:toastification/toastification.dart';

class NewBrandPage extends StatefulWidget {
  const NewBrandPage({super.key});

  @override
  State<NewBrandPage> createState() => _NewBrandPageState();
}

class _NewBrandPageState extends State<NewBrandPage> {
  final TextEditingController nomeMarcaController = TextEditingController();

  void limparCampos() {
    nomeMarcaController.text = "";
  }

  void salvar() {
    if (nomeMarcaController.text.isEmpty) {
      showToast(context, "Ops... Algo deu errado!", "Preencha o campo marca.",
          ToastificationType.warning);
      return;
    }

    BrandModel marca = BrandModel(
        id: 0,
        nomeMarca: nomeMarcaController.text.trim(),
        dataHoraCriacao: DateTime.now(),
        dataHoraModificacao: DateTime.now(),
        dataHoraSincronizacao: DateTime(2000, 1, 1));

    create(marca);
    limparCampos();

    showToast(context, "Sucesso", "A marca foi inserida com sucesso!",
        ToastificationType.success);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        title: const Text("Nova Marca"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[400],
        onPressed: () => {salvar()},
        child: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Align(
              alignment: FractionalOffset.centerLeft,
              child: Text("Nome da Marca:"),
            ),
            TextField(
              controller: nomeMarcaController,
              maxLength: 50,
              decoration: const InputDecoration(
                hintText: 'Ex: Coca Cola',
              ),
            )
          ],
        ),
      ),
    );
  }
}

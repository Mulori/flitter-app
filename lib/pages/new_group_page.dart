import 'package:flitter/components/toast.dart';
import 'package:flitter/models/group_model.dart';
import 'package:flitter/repositories/Entity/group.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class NewGroupPage extends StatefulWidget {
  const NewGroupPage({super.key});

  @override
  State<NewGroupPage> createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  final TextEditingController nomeGrupoController = TextEditingController();

  void limparCampos() {
    nomeGrupoController.text = "";
  }

  void salvar() {
    if (nomeGrupoController.text.isEmpty) {
      showToast(context, "Ops... Algo deu errado!",
          "Preencha o campo nome do grupo.", ToastificationType.warning);
      return;
    }

    GroupModel marca = GroupModel(
        id: 0,
        nomeGrupo: nomeGrupoController.text.trim(),
        dataHoraCriacao: DateTime.now(),
        dataHoraModificacao: DateTime.now(),
        dataHoraSincronizacao: DateTime(2000, 1, 1));

    createGroup(marca);
    limparCampos();

    showToast(context, "Sucesso", "O grupo foi inserido com sucesso!",
        ToastificationType.success);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        title: const Text("Novo Grupo"),
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
              child: Text("Nome do Grupo:"),
            ),
            TextField(
              controller: nomeGrupoController,
              maxLength: 50,
              decoration: const InputDecoration(
                hintText: 'Ex: Bebidas',
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}

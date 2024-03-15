import 'package:flitter/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:flitter/repositories/Entity/brand.dart';

class NewBrandPage extends StatefulWidget {
  const NewBrandPage({super.key});

  @override
  State<NewBrandPage> createState() => _NewBrandPageState();
}

class _NewBrandPageState extends State<NewBrandPage> {
  final TextEditingController nomeMarcaController = TextEditingController();

  void salvar() {
    if (nomeMarcaController.text.isEmpty) {
      return;
    }

    BrandModel marca = BrandModel(
        id: 0,
        nomeMarca: nomeMarcaController.text.trim(),
        dataHoraCriacao: DateTime.now(),
        dataHoraModificacao: DateTime.now(),
        dataHoraSincronizacao: DateTime(2000, 1, 1));

    create(marca);
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
        child: Icon(Icons.save),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: nomeMarcaController,
              maxLength: 50,
              decoration: const InputDecoration(
                labelText: 'Nome da Marca',
                hintText: 'Ex: Fashion',
                border: OutlineInputBorder(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

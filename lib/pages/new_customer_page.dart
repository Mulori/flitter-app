import 'package:flitter/components/toast.dart';
import 'package:flitter/models/customer_model.dart';
import 'package:flitter/repositories/Entity/customer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:toastification/toastification.dart';
import 'package:dio/dio.dart';

class NewCustomerPage extends StatefulWidget {
  const NewCustomerPage({super.key});

  @override
  State<NewCustomerPage> createState() => _NewCustomerPageState();
}

class _NewCustomerPageState extends State<NewCustomerPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController cpfCnpjController =
      MaskedTextController(mask: '000.000.000-00');
  final TextEditingController cidadeController = TextEditingController();
  String ufSelecionada = 'SP';
  final dio = Dio();

  void limparCampos() {
    nomeController.text = "";
  }

  void salvar() {
    if (nomeController.text.isEmpty) {
      showToast(context, "Ops... Algo deu errado!", "Preencha o campo marca.",
          ToastificationType.warning);
      return;
    }

    CustomerModel cliente = CustomerModel(
        id: 0,
        nome: nomeController.text.trim(),
        cep: cepController.text,
        endereco: enderecoController.text,
        numero: numeroController.text,
        bairro: bairroController.text,
        cpfCnpj: cpfCnpjController.text,
        cidade: cidadeController.text,
        uf: ufSelecionada,
        tipoPessoa: "F",
        dataHoraCriacao: DateTime.now(),
        dataHoraModificacao: DateTime.now(),
        dataHoraSincronizacao: DateTime(2000, 1, 1));

    createCustomer(cliente);
    limparCampos();

    showToast(context, "Sucesso", "O cliente foi inserido com sucesso!",
        ToastificationType.success);
    Navigator.of(context).pop();
  }

  void buscaCep() async {
    if (cepController.text.length == 8) {
      var cep = cepController.text
          .trim()
          .replaceAll('-', '')
          .replaceAll('.', '')
          .replaceAll(',', '');

      try {
        final response = await dio.get('https://viacep.com.br/ws/$cep/json/');
        Map<String, dynamic> dataCEP = response.data;

        if (!dataCEP.containsKey('erro')) {
          setState(() {
            cidadeController.text = dataCEP['localidade'].toString();
            bairroController.text = dataCEP['bairro'].toString();
            enderecoController.text = dataCEP['logradouro'].toString();
            ufSelecionada = dataCEP['uf'].toString();
          });
        }
      } catch (e) {
        print('Erro ao buscar dados do usuário: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        title: const Text("Novo Cliente"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[400],
        onPressed: () => {salvar()},
        child: const Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Align(
                alignment: FractionalOffset.centerLeft,
                child: Text("Nome:"),
              ),
              TextField(
                controller: nomeController,
                maxLength: 80,
                decoration: const InputDecoration(
                  hintText: 'Ex: Fulando de Tal',
                ),
              ),
              const Align(
                alignment: FractionalOffset.centerLeft,
                child: Text("CPF/CNPJ:"),
              ),
              TextField(
                controller: cpfCnpjController,
                maxLength: 14,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Ex: 999.999.999-99',
                ),
              ),
              const Align(
                alignment: FractionalOffset.centerLeft,
                child: Text("CEP:"),
              ),
              TextField(
                controller: cepController,
                maxLength: 8,
                onChanged: (value) => {buscaCep()},
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                decoration: const InputDecoration(
                  hintText: 'Ex: 00000-000',
                ),
              ),
              const Align(
                alignment: FractionalOffset.centerLeft,
                child: Text("Endereço:"),
              ),
              TextField(
                controller: enderecoController,
                maxLength: 80,
                decoration: const InputDecoration(
                  hintText: 'Ex: Rua Campos',
                ),
              ),
              const Align(
                alignment: FractionalOffset.centerLeft,
                child: Text("Numero:"),
              ),
              TextField(
                controller: numeroController,
                maxLength: 7,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Ex: 1101',
                ),
              ),
              const Align(
                alignment: FractionalOffset.centerLeft,
                child: Text("Bairro:"),
              ),
              TextField(
                controller: bairroController,
                maxLength: 50,
                decoration: const InputDecoration(
                  hintText: 'Ex: Vila das Flores',
                ),
              ),
              const Align(
                alignment: FractionalOffset.centerLeft,
                child: Text("Cidade:"),
              ),
              TextField(
                controller: cidadeController,
                maxLength: 80,
                decoration: const InputDecoration(
                  hintText: 'Ex: Bebedouro',
                ),
              ),
              const Align(
                alignment: FractionalOffset.centerLeft,
                child: Text("Selecione a UF:"),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButtonHideUnderline(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DropdownButton<String>(
                      isDense: true,
                      isExpanded: true,
                      onChanged: (String? novoItemSelecionado) {
                        setState(() {
                          ufSelecionada = novoItemSelecionado!;
                        });
                      },
                      value: ufSelecionada,
                      items: <String>[
                        'AC',
                        'AL',
                        'AP',
                        'AM',
                        'BA',
                        'CE',
                        'DF',
                        'ES',
                        'GO',
                        'MA',
                        'MT',
                        'MS',
                        'MG',
                        'PA',
                        'PB',
                        'PR',
                        'PE',
                        'PI',
                        'RJ',
                        'RN',
                        'RS',
                        'RO',
                        'RR',
                        'SC',
                        'SP',
                        'SE',
                        'TO',
                      ].map<DropdownMenuItem<String>>((String valor) {
                        return DropdownMenuItem<String>(
                          value: valor,
                          child: Text(valor),
                        );
                      }).toList(),
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

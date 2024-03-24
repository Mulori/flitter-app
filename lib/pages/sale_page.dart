import 'package:flitter/components/toast.dart';
import 'package:flitter/models/sale_model.dart';
import 'package:flitter/pages/detail_sale_page.dart';
import 'package:flitter/repositories/Entity/sale.dart';
import 'package:flutter/material.dart';
import 'package:flitter/models/customer_model.dart';
import 'package:flitter/repositories/Entity/customer.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

class SalePage extends StatefulWidget {
  const SalePage({Key? key}) : super(key: key);

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  List<CustomerModel> listaCliente = [];
  List<SaleModel> listaVenda = [];
  CustomerModel? clienteSelecionado;

  @override
  void initState() {
    super.initState();
    carregaListaVendas();
    carregaListaClientes();
  }

  Future<void> carregaListaClientes() async {
    await getCustomer().then((value) {
      setState(() {
        listaCliente = value;
        if (value.isNotEmpty) {
          clienteSelecionado = value[0];
        }
      });
    });
  }

  Future<void> carregaListaVendas() async {
    await getSalePending().then((value) {
      setState(() {
        listaVenda = value;
      });
    });
  }

  Future<void> refreshList() async {
    await getSalePending().then((value) => {
          setState(() {
            listaVenda = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        title: const Text("Pedidos"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[400],
        onPressed: () => {
          carregaListaClientes(),
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return NewSaleDialog(
                listaCliente: listaCliente,
                clienteSelecionado: clienteSelecionado,
              );
            },
          )
        },
        child: const Icon(Icons.add_box),
      ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: ListView.builder(
          itemCount: listaVenda.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DetailSalePage(idVenda: listaVenda[index].id)))
              },
              child: ListTile(
                title: Text(
                    '#${listaVenda[index].comanda}  Cliente: ${listaVenda[index].nomeCliente}  '),
                subtitle: Text(
                    'Total:${listaVenda[index].valorTotal}    Abertura: ${DateFormat('dd/MM/yyyy HH:mm:ss').format(listaVenda[index].dataHoraCriacao)}'),
              ),
            );
          },
        ),
      ),
    );
  }
}

class NewSaleDialog extends StatefulWidget {
  final List<CustomerModel> listaCliente;
  final CustomerModel? clienteSelecionado;

  const NewSaleDialog({
    required this.listaCliente,
    required this.clienteSelecionado,
  });

  @override
  _NewSaleDialogState createState() => _NewSaleDialogState();
}

class _NewSaleDialogState extends State<NewSaleDialog> {
  CustomerModel? _selectedCustomer;
  final TextEditingController comandaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedCustomer = widget.clienteSelecionado;
  }

  void novaVenda() async {
    if (comandaController.text.trim().isEmpty) {
      showToast(
          context, "Atenção", "Informe a comanda", ToastificationType.error);
      return;
    }

    var comandaPendente =
        await getSalePendingByComanda(comandaController.text.trim());

    if (comandaPendente.isNotEmpty) {
      showToast(
          context,
          "Atenção",
          "Já existe um pedido aberto com esta comanda.",
          ToastificationType.error);
      return;
    }

    SaleModel venda = SaleModel(
      id: 0,
      clienteId: _selectedCustomer?.id ?? 0,
      valorTotal: 0.0,
      status: 'P',
      nomeCliente: '',
      comanda: comandaController.text.trim(),
      cpfCnpj: '',
      dataFechamento: DateTime(2000, 1, 1),
      dataHoraCriacao: DateTime.now(),
      dataHoraModificacao: DateTime.now(),
      dataHoraSincronizacao: DateTime(2000, 1, 1),
    );

    var id = await createSale(venda);

    Navigator.of(context).pop();
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => DetailSalePage(idVenda: id)));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Novo pedido'),
      content: const Text('Informe os dados abaixo para iniciar'),
      actions: <Widget>[
        Column(
          children: [
            const Align(
                alignment: FractionalOffset.centerLeft,
                child: Text("Comanda: *")),
            TextField(
              controller: comandaController,
              maxLength: 50,
              decoration: const InputDecoration(
                hintText: 'Ex: Mesa 10',
              ),
            ),
            const Align(
              alignment: FractionalOffset.centerLeft,
              child: Text("Selecione o Cliente:"),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: DropdownButtonHideUnderline(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButton<CustomerModel>(
                    isDense: true,
                    isExpanded: true,
                    value: _selectedCustomer,
                    items: widget.listaCliente.map((CustomerModel grupo) {
                      return DropdownMenuItem<CustomerModel>(
                        value: grupo,
                        child: Text(grupo.nome),
                      );
                    }).toList(),
                    onChanged: (CustomerModel? novaClienteSelecionada) {
                      setState(() {
                        _selectedCustomer = novaClienteSelecionada;
                      });
                    },
                  ),
                ),
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
                  child: const Text("Avançar"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

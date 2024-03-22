import 'package:flitter/models/customer_model.dart';
import 'package:flitter/pages/new_customer_page.dart';
import 'package:flitter/repositories/Entity/customer.dart';
import 'package:flutter/material.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  List<CustomerModel> lista = [];

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  Future<void> _refreshList() async {
    await getCustomer().then((value) => {
          setState(() {
            lista = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        title: const Text("Clientes"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[400],
        onPressed: () => {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const NewCustomerPage()))
        },
        child: const Icon(Icons.add_box),
      ),
      body: RefreshIndicator(
        color: Colors.amber[400],
        onRefresh: _refreshList,
        child: ListView.builder(
            itemCount: lista.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  title: Text('#${lista[index].id} ${lista[index].nome}'));
            }),
      ),
    );
    ;
  }
}

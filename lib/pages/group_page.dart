import 'package:flitter/models/group_model.dart';
import 'package:flitter/pages/new_group_page.dart';
import 'package:flitter/repositories/Entity/group.dart';
import 'package:flutter/material.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  List<GroupModel> lista = [];

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  Future<void> _refreshList() async {
    await getGroup().then((value) => {
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
        title: const Text("Grupos"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[400],
        onPressed: () => {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const NewGroupPage()))
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
                  title: Text('#${lista[index].id} ${lista[index].nomeGrupo}'));
            }),
      ),
    );
  }
}

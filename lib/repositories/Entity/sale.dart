import 'package:flitter/models/sale_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flitter/repositories/database_helper.dart';

Future createSale(SaleModel model) async {
  try {
    final Database db = await getDatabase();

    int id = await db.insert(
      "vendas",
      model.toMap(),
    );

    return id;
  } catch (ex) {
    print(ex);
    return;
  }
}

Future<List<SaleModel>> getSalePending() async {
  try {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "select v.*, c.nome as nomeCliente from vendas v left join clientes c on v.cliente_id = c.id where status = 'P'");

    return List.generate(
      maps.length,
      (i) {
        return SaleModel.fromMap(maps[i]);
      },
    );
  } catch (ex) {
    print(ex);
    return [];
  }
}

Future<List<SaleModel>> getSalePendingByComanda(String comanda) async {
  try {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "select v.*, c.nome as nomeCliente from vendas v left join clientes c on v.cliente_id = c.id  where status = 'P' and comanda = '$comanda'");

    return List.generate(
      maps.length,
      (i) {
        return SaleModel.fromMap(maps[i]);
      },
    );
  } catch (ex) {
    print(ex);
    return [];
  }
}

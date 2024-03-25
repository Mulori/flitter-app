import 'package:flitter/models/item_sale_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flitter/repositories/database_helper.dart';

Future createItemSale(ItemSaleModel model) async {
  try {
    final Database db = await getDatabase();

    int id = await db.insert(
      "itens_vendas",
      model.toMap(),
    );

    await db.rawUpdate(
        "update vendas set valor_total = (select sum(valor_total) from itens_vendas where venda_id = vendas.id)");

    return id;
  } catch (ex) {
    print(ex);
    return;
  }
}

Future<List<ItemSaleModel>> getItensBySale(int id) async {
  try {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "select v.*, p.titulo_do_produto as titulo from itens_vendas v left join produtos p on v.produto_id = p.id where v.status = 'P' and v.venda_id = '$id'");

    return List.generate(
      maps.length,
      (i) {
        return ItemSaleModel.fromMap(maps[i]);
      },
    );
  } catch (ex) {
    print(ex);
    return [];
  }
}

Future<List<ItemSaleModel>> getItensById(int id) async {
  try {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "select v.*, p.titulo_do_produto as titulo from itens_vendas v left join produtos p on v.produto_id = p.id where v.id = '$id'");

    return List.generate(
      maps.length,
      (i) {
        return ItemSaleModel.fromMap(maps[i]);
      },
    );
  } catch (ex) {
    print(ex);
    return [];
  }
}

Future deleteItem(int id) async {
  try {
    final Database db = await getDatabase();
    await db.delete(
      "itens_vendas",
      where: "id = ?",
      whereArgs: [id],
    );

    await db.rawUpdate(
        "update vendas set valor_total = (select sum(valor_total) from itens_vendas where venda_id = vendas.id)");
  } catch (ex) {
    print(ex);
    return;
  }
}

Future updateItemQtde(int id, double qtde) async {
  try {
    final Database db = await getDatabase();
    await db.update(
      "itens_vendas",
      {'quantidade': qtde},
      where: "id = ?",
      whereArgs: [id],
    );

    await db.rawUpdate(
        "update itens_vendas set valor_total = (preco * quantidade) where id = ?",
        [id]);

    await db.rawUpdate(
        "update vendas set valor_total = (select sum(valor_total) from itens_vendas where venda_id = vendas.id)");
  } catch (ex) {
    print(ex);
    return;
  }
}

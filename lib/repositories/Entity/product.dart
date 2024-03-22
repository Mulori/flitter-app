import 'package:flitter/models/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flitter/repositories/database_helper.dart';

Future createProduct(ProductModel model) async {
  try {
    final Database db = await getDatabase();

    int id = await db.insert(
      "produtos",
      model.toMap(),
    );

    if (model.codigoDeBarras.isEmpty) {
      if (model.codigoDeBarras.isEmpty) {
        String formattedBarcode = id.toString().padLeft(13, '0');

        await db.update(
          "produtos",
          {'codigo_de_barras': formattedBarcode},
          where: "id = ?",
          whereArgs: [id],
        );
      }
    }
  } catch (ex) {
    print(ex);
    return;
  }
}

Future updateProduct(ProductModel model) async {
  try {
    final Database db = await getDatabase();
    await db.update(
      "produtos",
      model.toMap(),
      where: "id = ?",
      whereArgs: [model.id],
    );
  } catch (ex) {
    print(ex);
    return;
  }
}

Future deleteProduct(int id) async {
  try {
    final Database db = await getDatabase();
    await db.delete(
      "produtos",
      where: "id = ?",
      whereArgs: [id],
    );
  } catch (ex) {
    print(ex);
    return;
  }
}

Future<List<ProductModel>> getProdutos() async {
  try {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps =
        await db.rawQuery("select * from produtos");

    return List.generate(
      maps.length,
      (i) {
        return ProductModel.fromMap(maps[i]);
      },
    );
  } catch (ex) {
    print(ex);
    return [];
  }
}

Future<List<ProductModel>> getProdutoByEAN(String ean) async {
  try {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db
        .rawQuery("select * from produtos where codigo_de_barras = '$ean'");

    return List.generate(
      maps.length,
      (i) {
        return ProductModel.fromMap(maps[i]);
      },
    );
  } catch (ex) {
    print(ex);
    return [];
  }
}

Future<List<ProductModel>> getProdutoByEANID(String ean, int id) async {
  try {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "select * from produtos where codigo_de_barras = '$ean' and id not in($id)");

    return List.generate(
      maps.length,
      (i) {
        return ProductModel.fromMap(maps[i]);
      },
    );
  } catch (ex) {
    print(ex);
    return [];
  }
}

Future<List<ProductModel>> getProdutoByGrupo(int grupo) async {
  try {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps =
        await db.rawQuery("select * from produtos where grupo_id = '$grupo'");

    return List.generate(
      maps.length,
      (i) {
        return ProductModel.fromMap(maps[i]);
      },
    );
  } catch (ex) {
    print(ex);
    return [];
  }
}

Future<List<ProductModel>> getProdutoById(int id) async {
  try {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps =
        await db.rawQuery("select * from produtos where id = '$id'");

    return List.generate(
      maps.length,
      (i) {
        return ProductModel.fromMap(maps[i]);
      },
    );
  } catch (ex) {
    print(ex);
    return [];
  }
}

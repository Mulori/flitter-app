import 'package:flitter/models/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flitter/repositories/database_helper.dart';

Future createProduct(ProductModel model) async {
  try {
    final Database db = await getDatabase();

    await db.insert(
      "produtos",
      model.toMap(),
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

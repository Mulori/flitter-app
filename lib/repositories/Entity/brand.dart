import 'package:flitter/models/brand_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flitter/repositories/database_helper.dart';

Future create(BrandModel model) async {
  try {
    final Database db = await getDatabase();

    await db.insert(
      "marcas",
      model.toMap(),
    );
  } catch (ex) {
    print(ex);
    return;
  }
}

Future<List<BrandModel>> getBrand() async {
  try {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps =
        await db.rawQuery("select * from marcas");

    return List.generate(
      maps.length,
      (i) {
        return BrandModel.fromMap(maps[i]);
      },
    );
  } catch (ex) {
    print(ex);
    return [];
  }
}

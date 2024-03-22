import 'package:flitter/models/customer_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flitter/repositories/database_helper.dart';

Future createCustomer(CustomerModel model) async {
  try {
    final Database db = await getDatabase();

    await db.insert(
      "clientes",
      model.toMap(),
    );
  } catch (ex) {
    print(ex);
    return;
  }
}

Future<List<CustomerModel>> getCustomer() async {
  try {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps =
        await db.rawQuery("select * from clientes");

    return List.generate(
      maps.length,
      (i) {
        return CustomerModel.fromMap(maps[i]);
      },
    );
  } catch (ex) {
    print(ex);
    return [];
  }
}

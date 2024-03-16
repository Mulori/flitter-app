import 'package:flitter/models/group_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flitter/repositories/database_helper.dart';

Future createGroup(GroupModel model) async {
  try {
    final Database db = await getDatabase();

    await db.insert(
      "grupos",
      model.toMap(),
    );
  } catch (ex) {
    print(ex);
    return;
  }
}

Future<List<GroupModel>> getGroup() async {
  try {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps =
        await db.rawQuery("select * from grupos");

    return List.generate(
      maps.length,
      (i) {
        return GroupModel.fromMap(maps[i]);
      },
    );
  } catch (ex) {
    print(ex);
    return [];
  }
}

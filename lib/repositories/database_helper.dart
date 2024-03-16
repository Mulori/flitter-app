import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
// ignore: unused_import
import 'package:path_provider/path_provider.dart';
import 'dart:async';

String createTableMarcas =
    'CREATE TABLE marcas (id INTEGER PRIMARY KEY AUTOINCREMENT, nome_marca TEXT, data_hora_criacao DATETIME, data_hora_modificacao DATETIME, data_hora_sincronizacao DATETIME);';

String createTableGrupos =
    'CREATE TABLE grupos (id INTEGER PRIMARY KEY AUTOINCREMENT, nome_grupo TEXT, data_hora_criacao DATETIME, data_hora_modificacao DATETIME, data_hora_sincronizacao DATETIME);';

String createTableProdutos =
    'CREATE TABLE produtos (id INTEGER PRIMARY KEY AUTOINCREMENT, codigo_de_barras TEXT,  titulo_do_produto TEXT, valor_de_custo REAL, valor_de_venda REAL, quantidade_de_estoque REAL, marca_id INTEGER, grupo_id INTEGER, tipo_imagem INTEGER, caminho_imagem TEXT, data_hora_criacao DATETIME, data_hora_modificacao DATETIME, data_hora_sincronizacao DATETIME, FOREIGN KEY (marca_id) REFERENCES marcas(id), FOREIGN KEY (grupo_id) REFERENCES grupos(id));';

Future<Database> getDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), "flitter.db"),
    onCreate: onCreate,
    onConfigure: (db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    },
    onUpgrade: onUpgrade,
    version: 1,
  );
}

void onCreate(Database db, int newVersion) {
  db.execute(createTableMarcas);
  db.execute(createTableGrupos);
  db.execute(createTableProdutos);
}

void onUpgrade(Database db, int oldVersion, int newVersion) {
  if (oldVersion < newVersion) {}
}

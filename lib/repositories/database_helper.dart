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

String createTableClientes =
    'CREATE TABLE clientes (id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, cep TEXT, endereco TEXT, numero TEXT, bairro TEXT, cidade TEXT, uf TEXT, cpfCnpj TEXT, tipoPessoa TEXT, data_hora_criacao DATETIME, data_hora_modificacao DATETIME, data_hora_sincronizacao DATETIME);';

String createTableVendas =
    'CREATE TABLE vendas (id INTEGER PRIMARY KEY AUTOINCREMENT, cliente_id INTEGER, data_fechamento DATETIME, valor_total REAL, status TEXT, comanda TEXT, cpfCnpj TEXT, data_hora_criacao DATETIME, data_hora_modificacao DATETIME, data_hora_sincronizacao DATETIME, FOREIGN KEY (cliente_id) REFERENCES clientes(id));';

String createTableItensVendas =
    'CREATE TABLE itens_vendas (id INTEGER PRIMARY KEY AUTOINCREMENT, venda_id INTEGER, produto_id INTEGER, status TEXT, preco REAL, quantidade REAL, desconto REAL, valor_total REAL, data_hora_criacao DATETIME, data_hora_modificacao DATETIME, data_hora_sincronizacao DATETIME, FOREIGN KEY (venda_id) REFERENCES vendas(id), FOREIGN KEY (produto_id) REFERENCES produtos(id));';

Future<Database> getDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), "flitter.db"),
    onCreate: onCreate,
    onConfigure: (db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    },
    onUpgrade: onUpgrade,
    version: 6,
  );
}

void onCreate(Database db, int newVersion) {
  db.execute(createTableMarcas);
  db.execute(createTableGrupos);
  db.execute(createTableProdutos);
  db.execute(createTableClientes);
  db.execute(createTableVendas);
  db.execute(createTableItensVendas);
}

void onUpgrade(Database db, int oldVersion, int newVersion) {
  if (oldVersion < newVersion) {}
}

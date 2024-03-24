import 'dart:ffi';

class ItemSaleModel {
  final int id;
  final int vendaId;
  final int produtoId;
  final String tituloProduto;
  final String status;
  final double preco;
  final double quantidade;
  final double desconto;
  final double valorTotal;
  final DateTime dataHoraCriacao;
  final DateTime dataHoraModificacao;
  final DateTime dataHoraSincronizacao;

  ItemSaleModel(
      {required this.id,
      required this.vendaId,
      required this.produtoId,
      required this.tituloProduto,
      required this.status,
      required this.preco,
      required this.quantidade,
      required this.desconto,
      required this.valorTotal,
      required this.dataHoraCriacao,
      required this.dataHoraModificacao,
      required this.dataHoraSincronizacao});

  Map<String, dynamic> toMap() {
    return {
      'venda_id': vendaId,
      'produto_id': produtoId,
      'status': status,
      'preco': preco,
      'quantidade': quantidade,
      'desconto': desconto,
      'valor_total': valorTotal,
      'data_hora_criacao': dataHoraCriacao.toIso8601String(),
      'data_hora_modificacao': dataHoraModificacao.toIso8601String(),
      'data_hora_sincronizacao': dataHoraSincronizacao.toIso8601String(),
    };
  }

  factory ItemSaleModel.fromMap(Map<String, dynamic> map) {
    return ItemSaleModel(
      id: map['id'],
      vendaId: map['venda_id'],
      produtoId: map['produto_id'],
      tituloProduto: map['titulo'],
      status: map['status'],
      preco: map['preco'],
      quantidade: map['quantidade'],
      desconto: map['desconto'],
      valorTotal: map['valor_total'],
      dataHoraCriacao: DateTime.parse(map['data_hora_criacao']),
      dataHoraModificacao: DateTime.parse(map['data_hora_modificacao']),
      dataHoraSincronizacao: DateTime.parse(map['data_hora_sincronizacao']),
    );
  }
}

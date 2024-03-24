import 'dart:ffi';

class SaleModel {
  final int id;
  final int clienteId;
  final double valorTotal;
  final String status;
  final String comanda;
  final String cpfCnpj;
  final String nomeCliente;
  final DateTime dataFechamento;
  final DateTime dataHoraCriacao;
  final DateTime dataHoraModificacao;
  final DateTime dataHoraSincronizacao;

  SaleModel(
      {required this.id,
      required this.clienteId,
      required this.valorTotal,
      required this.status,
      required this.comanda,
      required this.nomeCliente,
      required this.cpfCnpj,
      required this.dataFechamento,
      required this.dataHoraCriacao,
      required this.dataHoraModificacao,
      required this.dataHoraSincronizacao});

  Map<String, dynamic> toMap() {
    return {
      'cliente_id': clienteId,
      'valor_total': valorTotal,
      'status': status,
      'comanda': comanda,
      'cpfCnpj': cpfCnpj,
      'data_fechamento': dataFechamento.toIso8601String(),
      'data_hora_criacao': dataHoraCriacao.toIso8601String(),
      'data_hora_modificacao': dataHoraModificacao.toIso8601String(),
      'data_hora_sincronizacao': dataHoraSincronizacao.toIso8601String(),
    };
  }

  factory SaleModel.fromMap(Map<String, dynamic> map) {
    return SaleModel(
      id: map['id'],
      clienteId: map['cliente_id'],
      valorTotal: map['valor_total'],
      status: map['status'],
      comanda: map['comanda'],
      cpfCnpj: map['cpfCnpj'],
      nomeCliente: map['nomeCliente'],
      dataFechamento: DateTime.parse(map['data_fechamento']),
      dataHoraCriacao: DateTime.parse(map['data_hora_criacao']),
      dataHoraModificacao: DateTime.parse(map['data_hora_modificacao']),
      dataHoraSincronizacao: DateTime.parse(map['data_hora_sincronizacao']),
    );
  }
}

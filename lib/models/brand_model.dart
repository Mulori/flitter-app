class BrandModel {
  final int id;
  final String nomeMarca;
  final DateTime dataHoraCriacao;
  final DateTime dataHoraModificacao;
  final DateTime dataHoraSincronizacao;

  BrandModel(
      {required this.id,
      required this.nomeMarca,
      required this.dataHoraCriacao,
      required this.dataHoraModificacao,
      required this.dataHoraSincronizacao});

  Map<String, dynamic> toMap() {
    return {
      'nome_marca': nomeMarca,
      'data_hora_criacao': dataHoraCriacao.toIso8601String(),
      'data_hora_modificacao': dataHoraModificacao.toIso8601String(),
      'data_hora_sincronizacao': dataHoraSincronizacao.toIso8601String(),
    };
  }

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      id: map['id'],
      nomeMarca: map['nome_marca'],
      dataHoraCriacao: DateTime.parse(map['data_hora_criacao']),
      dataHoraModificacao: DateTime.parse(map['data_hora_modificacao']),
      dataHoraSincronizacao: DateTime.parse(map['data_hora_sincronizacao']),
    );
  }
}

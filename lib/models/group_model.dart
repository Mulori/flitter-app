class GroupModel {
  final int id;
  final String nomeGrupo;
  final DateTime dataHoraCriacao;
  final DateTime dataHoraModificacao;
  final DateTime dataHoraSincronizacao;

  GroupModel(
      {required this.id,
      required this.nomeGrupo,
      required this.dataHoraCriacao,
      required this.dataHoraModificacao,
      required this.dataHoraSincronizacao});

  Map<String, dynamic> toMap() {
    return {
      'nome_grupo': nomeGrupo,
      'data_hora_criacao': dataHoraCriacao.toIso8601String(),
      'data_hora_modificacao': dataHoraModificacao.toIso8601String(),
      'data_hora_sincronizacao': dataHoraSincronizacao.toIso8601String(),
    };
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      id: map['id'],
      nomeGrupo: map['nome_grupo'],
      dataHoraCriacao: DateTime.parse(map['data_hora_criacao']),
      dataHoraModificacao: DateTime.parse(map['data_hora_modificacao']),
      dataHoraSincronizacao: DateTime.parse(map['data_hora_sincronizacao']),
    );
  }
}

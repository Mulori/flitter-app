class CustomerModel {
  final int id;
  final String nome;
  final String cep;
  final String endereco;
  final String numero;
  final String bairro;
  final String cidade;
  final String uf;
  final String cpfCnpj;
  final String tipoPessoa;
  final DateTime dataHoraCriacao;
  final DateTime dataHoraModificacao;
  final DateTime dataHoraSincronizacao;

  CustomerModel(
      {required this.id,
      required this.nome,
      required this.cep,
      required this.endereco,
      required this.numero,
      required this.bairro,
      required this.cidade,
      required this.uf,
      required this.cpfCnpj,
      required this.tipoPessoa,
      required this.dataHoraCriacao,
      required this.dataHoraModificacao,
      required this.dataHoraSincronizacao});

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'cep': cep,
      'endereco': endereco,
      'numero': numero,
      'bairro': bairro,
      'cidade': cidade,
      'uf': uf,
      'cpfCnpj': cpfCnpj,
      'tipoPessoa': tipoPessoa,
      'data_hora_criacao': dataHoraCriacao.toIso8601String(),
      'data_hora_modificacao': dataHoraModificacao.toIso8601String(),
      'data_hora_sincronizacao': dataHoraSincronizacao.toIso8601String(),
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'],
      nome: map['nome'],
      cep: map['cep'],
      endereco: map['endereco'],
      numero: map['numero'],
      bairro: map['bairro'],
      cidade: map['cidade'],
      uf: map['uf'],
      cpfCnpj: map['cpfCnpj'],
      tipoPessoa: map['tipoPessoa'],
      dataHoraCriacao: DateTime.parse(map['data_hora_criacao']),
      dataHoraModificacao: DateTime.parse(map['data_hora_modificacao']),
      dataHoraSincronizacao: DateTime.parse(map['data_hora_sincronizacao']),
    );
  }
}

class ProductModel {
  final int id;
  final String codigoDeBarras;
  final String tituloDoProduto;
  final double valorDeCusto;
  final double valorDeVenda;
  final double estoqueProduto;
  final int marca;
  final int grupo;
  final int tipoImagem;
  final String caminhoImagem;
  final DateTime dataHoraCriacao;
  final DateTime dataHoraModificacao;
  final DateTime dataHoraSincronizacao;

  ProductModel(
      {required this.id,
      required this.codigoDeBarras,
      required this.tituloDoProduto,
      required this.valorDeCusto,
      required this.valorDeVenda,
      required this.estoqueProduto,
      required this.marca,
      required this.grupo,
      required this.tipoImagem,
      required this.caminhoImagem,
      required this.dataHoraCriacao,
      required this.dataHoraModificacao,
      required this.dataHoraSincronizacao});

  Map<String, dynamic> toMap() {
    return {
      'codigo_de_barras': codigoDeBarras,
      'titulo_do_produto': tituloDoProduto,
      'valor_de_custo': valorDeCusto,
      'valor_de_venda': valorDeVenda,
      'quantidade_de_estoque': estoqueProduto,
      'marca_id': marca,
      'grupo_id': grupo,
      'tipo_imagem': tipoImagem,
      'caminho_imagem': caminhoImagem,
      'data_hora_criacao': dataHoraCriacao.toIso8601String(),
      'data_hora_modificacao': dataHoraModificacao.toIso8601String(),
      'data_hora_sincronizacao': dataHoraSincronizacao.toIso8601String(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      codigoDeBarras: map['codigo_de_barras'],
      tituloDoProduto: map['titulo_do_produto'],
      valorDeCusto: map['valor_de_custo'],
      valorDeVenda: map['valor_de_venda'],
      estoqueProduto: map['quantidade_de_estoque'],
      marca: map['marca_id'],
      grupo: map['grupo_id'],
      tipoImagem: map['tipo_imagem'],
      caminhoImagem: map['caminho_imagem'],
      dataHoraCriacao: DateTime.parse(map['data_hora_criacao']),
      dataHoraModificacao: DateTime.parse(map['data_hora_modificacao']),
      dataHoraSincronizacao: DateTime.parse(map['data_hora_sincronizacao']),
    );
  }
}

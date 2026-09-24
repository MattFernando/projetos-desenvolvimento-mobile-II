class ProdutoModel {
  int? id;
  final String nome;
  final String descricao;
  final String categoria;
  final double preco;

  ProdutoModel({
    required this.nome,
    required this.descricao,
    required this.categoria,
    required this.preco,
    this.id,
  });

  factory ProdutoModel.fromJson(Map json) {
    return ProdutoModel(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      categoria: json['categoria'],
      preco: json['preco'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nome": nome,
      "descricao": descricao,
      "categoria": categoria,
      "preco": preco,
    };
  }
}

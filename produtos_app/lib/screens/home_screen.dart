import 'package:flutter/material.dart';
import 'package:produtos_app/models/produto_model.dart';
import 'package:produtos_app/services/produto_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //============================================
  List<ProdutoModel> _listarProdutos = [];

  @override
  void initState() {
    super.initState();
    _carregarLista();
  }

  void _carregarLista() async {
    final produtos = await ProdutoBanco().listarProdutos();
    setState(() {
      _listarProdutos = produtos;
    });
  }

  void abrirFormulario(ProdutoModel? produto) {
    // removi o _ para que seja publico, _ torna privado
    final nomeController = TextEditingController(text: produto?.nome ?? '');
    final descricaoController = TextEditingController(
      text: produto?.descricao ?? '',
    );
    final categoriaController = TextEditingController(
      text: produto?.categoria ?? '',
    );
    final precoController = TextEditingController(
      text: produto?.preco.toString() ?? '',
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            produto?.id == null ? "Cadastro de produto" : "Edição produto",
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nomeController,
                  decoration: InputDecoration(label: Text("Nome")),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: descricaoController,
                  decoration: InputDecoration(label: Text("Descrição")),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: categoriaController,
                  decoration: InputDecoration(label: Text("Categoria")),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: precoController,
                  decoration: InputDecoration(label: Text("Preço")),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                // instancia produto e preenche com os dados digitados
                final dadosProduto = ProdutoModel(
                  id: produto?.id,
                  nome: nomeController.text,
                  descricao: descricaoController.text,
                  categoria: categoriaController.text,
                  preco: double.parse(precoController.text),
                );
                // chama função que salva os dados (caso Id seja nulo cria novo)
                _salvarDados(dadosProduto);
              },
              child: Text("Salvar"),
            ),
          ],
        );
      },
    );
  } //fim da função abrir formulario

  void _salvarDados(ProdutoModel produto) async {
    bool modoEdicao = produto.id == null;
    bool salvou = false;
    if (modoEdicao) {
      salvou = await ProdutoBanco().inserirProduto(produto);
    } else {
      salvou = await ProdutoBanco().atualizarProduto(produto);
    }git
    if (salvou) {
      //fecha modal formulario
      Navigator.of(context).pop();

      // carrega a lista novamente
      _carregarLista();

      //abre a modal de avisos
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(modoEdicao ? "Produto salvo!" : "Produto atualizado!"),
        ),
      );
    }
  } //fim da função salvar dados

  void _abrirModalExclusao(ProdutoModel produto) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Excluir produto"),
          content: Text("Deseja realmente excluir o produto ${produto.nome}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                deletarProduto(produto.id!);
                Navigator.pop(context);
              },
              child: Text("Excluir"),
            ),
          ],
        );
      },
    );
  }

  void deletarProduto(int id) async {
    bool deletou = await ProdutoBanco().deletarProduto(id);
    if (deletou) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Produto deletado com sucesso!")));
      _carregarLista();
    }
  }

  //============================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de produtos"),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: _listarProdutos.length, //conta numero de itens no array
        itemBuilder: (context, index) {
          final item = _listarProdutos[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text(item.nome),
              subtitle: Text(
                '${item.descricao} - ${item.categoria} - ${item.preco}',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => abrirFormulario(item),
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () => _abrirModalExclusao(item),
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),

              leading: CircleAvatar(child: Icon(Icons.person)),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          abrirFormulario(null); // enviar nulo porque é um cadastro
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:guia_turismo/models/lugaresModel.dart';
import 'package:guia_turismo/services/lugaresServices.dart';

class LugaresController extends ChangeNotifier{
  bool carregando = false;
  String erro = "";
  List<LugaresModel> _lugares = [];
  List<LugaresModel> get lugares => _lugares;

  // inicializar

  Future<void> listarLugares()async{
    carregando = true;
    notifyListeners();
    try{
      final lugaresService = LugaresServices();
      final listaLugares = await lugaresService.buscarLugares();
      _lugares = listaLugares;
    }catch(error){
      erro = "Erro ao listar: ${error.toString()}";
    }finally{
      carregando = false;
      notifyListeners();
    }
  }

  Future<String> cadastrarLugar(LugaresModel dados) async {
    //final token = await SessionService().pegarToken() ?? '';
    carregando = true;
    erro = '';
    notifyListeners();
    try{
      final lugaresService = LugaresServices();
      final resposta = await lugaresService.cadastrarLugar(dados, "");
      return resposta;
    }catch(e){
      erro = "Erro ao cadastrar: $e";
      return erro;
    }finally{
      carregando = false;
      notifyListeners();
    }
  }
}
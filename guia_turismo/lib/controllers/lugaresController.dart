import 'package:flutter/material.dart';
import 'package:guia_turismo/models/lugaresModel.dart';
import 'package:guia_turismo/services/lugaresServices.dart';

class Lugarescontroller extends ChangeNotifier{
  bool carregando = false;
  String erro = "";
  List<LugaresModel> _lugares = [];
  List<LugaresModel> get lugares => _lugares;

  // inicializar

  Future<void> listarLugares()async{
    carregando = true;
    notifyListeners();
    try{
      final LugaresService = LugaresServices();
      final listaLugares = await LugaresService.buscarLugares();
      _lugares = listaLugares;
    }catch(error){
      erro = "Erro ao listar: ${error.toString()}";
    }finally{
      carregando = false;
      notifyListeners();
    }
  }
}
import 'package:flutter/material.dart';
import 'package:guia_turismo/services/gps_service.dart';
import 'package:latlong2/latlong.dart';

class GpsController extends ChangeNotifier{
  final GpsService _servico = GpsService();
  LatLng? atual;
  List<LatLng> pins = [];
  bool carregando = false;
  String erro = "";

  Future<void> buscarLocal() async{
    //indicando que está carregando e avisando que ta tendo mudanças na tela
    carregando = true;
    notifyListeners();
    try{
      //tentando pegar a localização atual e caso nao venha nada dá erro
    atual = await _servico.obterLocal();
    if (atual == null){
      erro += "Erro ao buscar o local";
    }
    }catch(e){
      debugPrint("Erro: $e");
    }finally{
      carregando = false;
      notifyListeners();
    }
  }
}
import 'dart:convert';

import 'package:guia_turismo/models/lugaresModel.dart';
import 'package:http/http.dart' as http;

class Lugaresservices {
  String endpoint = "https/guiaturismo.onrender.com";
  int pagina = 1;
  int limite = 10;

  Future<List<LugaresModel>> BuscarLugares() async {
    try {
      final response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == 200){
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> data = responseData['data'];

        return data.map((item) => LugaresModel.fromJson(item)).toList();
      }else{
        throw Exception('Erro na requisição: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}

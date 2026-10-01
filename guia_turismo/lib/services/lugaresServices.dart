import 'package:guia_turismo/models/lugaresModel.dart';
import 'package:http/http.dart' as http;

class Lugaresservices {
  String endpoint = "https/guiaturismo.onrender.com";
  int pagina = 1;
  int limite = 10;

  Future<List<LugaresModel>> BuscarLugares() async {
    try {
      final response = await http.get(Uri.parse(endpoint));
    } catch (e) {}
  }
}

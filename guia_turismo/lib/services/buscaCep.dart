import 'dart:convert';
import 'package:http/http.dart' as http;

class BuscarcepService {

  static const _headers = {'User-Agent': 'GuiaTurismo/1.0 (br.com.guiaturismo.maps)'};

  Future <Map<String, dynamic>?> buscarCEP (String buscar) async {
    final cep = buscar.replaceAll(RegExp(r'\D'), '');


    final viacep = await http.get(Uri.https('viacep.com.br', '/ws/$cep/json/'));
    if (viacep.statusCode != 200) throw Exception('Erro ao buscar CEP');
    final endereco = jsonDecode(viacep.body);
    if (endereco['erro'] != null) return null;
    
    //respostas da API
    final respostaNom = await http.get(Uri.https(
      'nominatim.openstreetmap.org', '/search', {
        'street': endereco['logradouro'],
        'city': endereco['localidade'],
        'state': endereco['uf'],
        'country': 'Brasil',
        'format': 'jsonv2',
        'limit': '1',
    }),
    headers: _headers,
    );
    if (respostaNom.statusCode != 200) throw Exception('Erro ao buscar coordenadas');
    
    final List<dynamic> resultados = jsonDecode(respostaNom.body);
    return resultados.isEmpty ? null : resultados[0];

  }
}
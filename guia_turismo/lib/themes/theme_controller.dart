import 'package:flutter/material.dart';
import 'package:guia_turismo/themes/theme_widgets.dart';

class ThemeController extends ChangeNotifier {
  //notifierlisteners
  ThemeMode _temaAtual = ThemeMode.light;
  ThemeMode get temaAtual => _temaAtual;

  IconData get iconeAtual =>
      _temaAtual == ThemeMode.light ? Icons.light_mode : Icons.dark_mode;

  static ThemeData _mudarTema(Brightness brilho) {
    final cor = ColorScheme.fromSeed(
      seedColor: Colors.purple,
      brightness: brilho,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: cor,
      appBarTheme: defineAppBar(cor),
      bottomNavigationBarTheme: defineNavegacaoBase(cor),
      elevatedButtonTheme: defineBotaoElevated(cor),
    );
  }

  ThemeData temaClaro() => _mudarTema(Brightness.light);
  ThemeData temaEscuro() => _mudarTema(Brightness.dark);

  void alternarTema() {
    _temaAtual = _temaAtual == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }
}

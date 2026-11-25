import 'package:flutter/material.dart';

AppBarTheme defineAppBar(cor) {
  return AppBarTheme(
    centerTitle: true,
    backgroundColor: cor.primary,
    foregroundColor: cor.onPrimary,
    elevation: 4,
  );
}

BottomNavigationBarThemeData defineNavegacaoBase(cor) {
  final bool temaEscuro = cor.brightness == Brightness.dark;
  return BottomNavigationBarThemeData(
    backgroundColor: temaEscuro
        ? Colors.black
        : cor.primary,

    selectedItemColor: temaEscuro
        ? Colors.white
        : cor.primary,

    unselectedItemColor: temaEscuro
        ? Colors.white
        : cor.primary,


    elevation: 4,
  );
}

ElevatedButtonThemeData defineBotaoElevated(cor) {
  return ElevatedButtonThemeData(style: ElevatedButton.styleFrom());
}

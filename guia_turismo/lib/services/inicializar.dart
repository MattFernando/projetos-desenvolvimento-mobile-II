import 'package:flutter/material.dart';
import 'package:guia_turismo/screens/home_screen.dart';
import 'package:guia_turismo/themes/theme_controller.dart';
import 'package:provider/provider.dart';

class Inicializar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeController()),
      ],
      child: Consumer<ThemeController>(
        builder: (context, controllerTema, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: controllerTema.temaClaro(),
          darkTheme: controllerTema.temaEscuro(),
          themeMode: controllerTema.temaAtual,
          initialRoute: 'home',
          routes: {'home': (context) => HomeScreen()},
        ),
      ),
    );
  }
}

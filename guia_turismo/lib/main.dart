import 'package:flutter/material.dart';
import 'package:guia_turismo/controllers/auth.controller.dart';
import 'package:guia_turismo/controllers/camera_controller.dart';
import 'package:guia_turismo/controllers/lugaresController.dart';
import 'package:guia_turismo/screens/cadastro_lugar.dart';
import 'package:guia_turismo/screens/camera_screen.dart';
import 'package:guia_turismo/screens/home_screen.dart';
import 'package:guia_turismo/screens/login_screen.dart';
import 'package:guia_turismo/screens/lugaresScreen.dart';
import 'package:guia_turismo/services/inicializar.dart';
import 'package:guia_turismo/themes/theme_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Inicializar());
}

class Inicializar extends StatelessWidget {
  const Inicializar({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => LugaresController()),
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => ThemeController()),
        ChangeNotifierProvider(create: (_) => CameraController()),
      ],
    child: Consumer<ThemeController>(
        builder: (context, controllerThema, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: controllerThema.temaClaro(),
        darkTheme: controllerThema.temaEscuro(),
        themeMode: controllerThema.temaAtual,
        initialRoute: 'login',
        //Define as rotas e em quais classes devem ser chamadas
        routes: {
          'login': (context) => LoginScreen(),
          'home': (context) => HomeScreen(),
          'lugares': (context) => Lugaresscreen(),
          'camera': (context) => CameraScreen()
        },
      ),
    ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:guia_turismo/themes/theme_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guia de turismo!"),
        actions: [
          Consumer<ThemeController>(
            builder: (context, controllerTema, child) => IconButton(
              onPressed: () => controllerTema.alternarTema(),
              icon: Icon(controllerTema.iconeAtual),
            ),
          ),
        ],
      ),
    );
  }
}

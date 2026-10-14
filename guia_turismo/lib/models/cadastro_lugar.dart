import 'package:flutter/material.dart';
import 'package:guia_turismo/controllers/camera_controller.dart';
import 'package:provider/provider.dart';

class CadastroLugar extends StatefulWidget {
  const CadastroLugar({super.key});

  @override
  State<CadastroLugar> createState() => _CadastroLugarState();
}

class _CadastroLugarState extends State<CadastroLugar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CameraController>(
        builder:(context, controle, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
           children: [
            Stack(
              children: [
                Container(// o primeiro Widget do Stack é o fundo
                  decoration: BoxDecoration(
                    border: Border.all(width: 4),
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(image: FileImage(controle.imagemSelecionada!),
                      fit: BoxFit.cover
                    )
                  ),
                )
              ],
            )
           ],
        ),
      )
    );
  }
}


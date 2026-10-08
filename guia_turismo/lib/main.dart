import 'package:flutter/material.dart';
import 'package:guia_turismo/controllers/lugaresController.dart';
import 'package:guia_turismo/screens/lugaresScreen.dart';
import 'package:guia_turismo/services/inicializar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Inicializar());
}

class Inicializar extends StatefulWidget{
  const Inicializar({super.key});

  @override
  State<Inicializar> createState() => _inicializarState();
}
class _inicializarState extends State<Inicializar>{
  @override
  Widget build(BuildContext context){
    return MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (_) => LugaresController()..listarLugares(),
        ),
      ],
    child: Consumer<LugaresController>
    (
      builder: (context, LugaresController, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'lugares',
        routes:{
          'lugares': (context) => Lugaresscreen()
        }
      )
    ),
    );
  }
}
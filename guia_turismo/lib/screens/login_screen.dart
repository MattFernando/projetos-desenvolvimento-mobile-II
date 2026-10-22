import 'package:flutter/material.dart';
import 'package:guia_turismo/controllers/auth.controller.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Consumer<AuthController>(
        builder: (context, controle, _) => Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _email,
                decoration: InputDecoration(labelText: "E-mail"),
              ),
              TextField(
                controller: _senha,
                obscureText: true,
                decoration: InputDecoration(labelText: "Senha"),
              ),
              SizedBox(height: 16),
              Text(controle.erro), 
              ElevatedButton(
                onPressed: () async {
                  final logou = await controle.autenticarUsuario(_email.text, _senha.text);
                  if (logou && context.mounted) {
                    Navigator.pushNamed(context, 'home');
                  }
                },
                child: Text("Entrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
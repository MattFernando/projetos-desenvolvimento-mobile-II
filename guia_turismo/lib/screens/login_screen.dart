import 'package:flutter/material.dart';
import 'package:guia_turismo/controllers/auth.controller.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _senha = TextEditingController();
  User? _usuario;


  Future<void> _entrarComGoogle() async {
    try {
      late final UserCredential resultado;

      if (kIsWeb) {
        resultado = await FirebaseAuth.instance.signInWithPopup(
          GoogleAuthProvider(),
        );
      } else {
        final googleSignIn = GoogleSignIn.instance;
        await googleSignIn.initialize();

        final conta = await googleSignIn.authenticate();
        final credencial = GoogleAuthProvider.credential(
          idToken: conta.authentication.idToken,
        );

        resultado = await FirebaseAuth.instance.signInWithCredential(
          credencial,
        );
      }

      if (!mounted) return;
      setState(() => _usuario = resultado.user);
      _entrarLogado();
    } catch (e) {
      debugPrint('Erro ao autenticar: $e');
    }
  }

  Future<void> _entrarLogado() async {
    if (!mounted || _usuario == null) return;
    Navigator.pushNamed(context, 'home');
  }

  Future<void> _sair() async {
    try{
    await FirebaseAuth.instance.signOut();

    if(!kIsWeb){
      await GoogleSignIn.instance.signOut();
    }
    if(!mounted) return;

    setState(() {
      _usuario = null;
    });
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
    }catch(error){
      debugPrint("Não vai sair não: $error");
    }
    setState(() => _usuario = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Column(
        children: [
          Consumer<AuthController>(
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
                      final logou = await controle.autenticarUsuario(
                        _email.text,
                        _senha.text,
                      );
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
          SizedBox(height: 10),

          Center(
        child: _usuario == null
            ? ElevatedButton.icon(
                onPressed: _entrarComGoogle,
                icon: const Icon(Icons.login),
                label: const Text('Entrar com o Google'),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(_usuario!.photoURL ?? ''),
                    radius: 40,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _usuario!.displayName ?? 'Sem nome',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(_usuario!.email ?? 'Sem email'),
                  const SizedBox(height: 20),
                  ElevatedButton(onPressed: _entrarLogado, child: const Text('Entrar com essa conta')),
                  SizedBox(height: 10,),
                  ElevatedButton(onPressed: _sair, child: const Text('Sair')),
                ],
              ),
      ),
        ],
      ),
    );
  }
}

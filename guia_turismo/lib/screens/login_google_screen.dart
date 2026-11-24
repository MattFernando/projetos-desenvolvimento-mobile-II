import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  User? _usuario;

  Future<void> _entrarComGoogle() async {
    try {
      late final UserCredential resultado;

      if (kIsWeb) {
        final provider = GoogleAuthProvider();
        provider.setCustomParameters({'prompt': 'select_account'});
        resultado = await FirebaseAuth.instance.signInWithPopup(provider);
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

      if (_usuario != null) {
        Navigator.pushNamed(context, 'home');
      }
    } catch (e) {
      debugPrint('Erro ao autenticar: $e');
    }
  }

  Future<void> _sair() async {
    try {
      await FirebaseAuth.instance.signOut();

      if (!kIsWeb) {
        final googleSignIn = GoogleSignIn.instance;
        await googleSignIn.initialize();
        await googleSignIn.disconnect();
      }
    } catch (e) {
      debugPrint('Erro ao sair da conta: $e');
    } finally {
      if (mounted) {
        setState(() => _usuario = null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login com Google')),
      body: Center(
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
                  ElevatedButton(onPressed: _sair, child: const Text('Sair')),
                ],
              ),
      ),
    );
  }
}

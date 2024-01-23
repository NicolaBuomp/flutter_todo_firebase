import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/CustomSnackBar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController =
      TextEditingController(text: 'test@test.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '123456');

  Future<void> _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
          backgroundColor: Colors.green,
          text: 'Accesso riuscito!',
          onAction: () {
            print('hi');
          },
        ),
      );
      Navigator.pushNamed(context, 'todos');

    } catch (e) {
      String textMessage = 'Errore';
      if (e is FirebaseAuthException) {
        if (e.code == 'firebase_auth/invalid-credential') {
          textMessage = 'Errore durante l\'accesso: Credenziali errate';
        }
      }

      if (kDebugMode) {
        print('Errore durante l\'accesso: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
          backgroundColor: Colors.red,
          text: textMessage,
          onAction: () {
            print('hi');
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration:
                  const InputDecoration(labelText: 'Email', filled: true),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Accesso'),
            ),
          ],
        ),
      ),
    );
  }
}

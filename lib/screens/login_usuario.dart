import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginUsuarioScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final FlutterSecureStorage storage =
      FlutterSecureStorage(); // Definindo o 'storage'

  LoginUsuarioScreen({super.key});

  Future<void> login(BuildContext context) async {
    final email = emailController.text;
    final senha = senhaController.text;

    if (email.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos'),
        ),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3070/flutter/loginuser'),
        body: jsonEncode({'email': email, 'senha': senha}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Armazena o token no storage seguro
        if (data['token'] != null) {
          await storage.write(key: 'token', value: data['token']);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login bem-sucedido!')),
          );
          // Navegue para a tela principal
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro ao receber o token')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credenciais incorretas')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro de conexão')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC54444),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC54444),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 200,
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Entrar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Digite seus dados de acesso nos campos abaixo.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: const TextStyle(color: Colors.black),
                prefixIcon: const Icon(Icons.email, color: Colors.black),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: senhaController,
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: const TextStyle(color: Colors.black),
                prefixIcon: const Icon(Icons.lock, color: Colors.black),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              obscureText: true,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (bool? value) {},
                      activeColor: const Color(0xFF2B1C1C),
                    ),
                    const Text(
                      'Manter-me Logado',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Esqueceu a Senha?',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => login(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2B1C1C),
                minimumSize: const Size(double.infinity, 50),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Acessar',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cadastro');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2B1C1C),
                minimumSize: const Size(double.infinity, 50),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Criar conta',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

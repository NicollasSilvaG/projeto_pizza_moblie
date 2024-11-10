import 'package:flutter/material.dart';

class LoginUsuarioScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  LoginUsuarioScreen({super.key});

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
            // Row para alinhar "Esqueceu a Senha?" à direita e "Manter-me Logado" à esquerda
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Checkbox "Manter-me Logado" alinhado à esquerda
                Row(
                  children: [
                    Checkbox(
                      value: false, // Adicionar a lógica para controlar o estado
                      onChanged: (bool? value) {
                        // Atualizar o estado de manter-me logado aqui
                      },
                      activeColor: const Color(0xFF2B1C1C),
                    ),
                    const Text(
                      'Manter-me Logado',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                // Esqueceu a Senha alinhado à direita
                TextButton(
                  onPressed: () {
                    // Ação para recuperar a senha
                  },
                  child: const Text(
                    'Esqueceu a Senha?',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final email = emailController.text;
                final senha = senhaController.text;

                if (email.isEmpty || senha.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, preencha todos os campos'),
                    ),
                  );
                } else {
                  // Lógica de autenticação aqui
                  // Exemplo: navegação após login bem-sucedido
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
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

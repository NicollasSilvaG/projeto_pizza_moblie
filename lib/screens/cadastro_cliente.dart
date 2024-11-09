import 'package:flutter/material.dart';

class CadastroClienteScreen extends StatelessWidget {
  const CadastroClienteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Telefone'),
            ),
            // Outras entradas de formulário
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Função para realizar o cadastro
              },
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AlterarSenhaScreen extends StatefulWidget {
  const AlterarSenhaScreen({super.key});

  @override
  _AlterarSenhaScreenState createState() => _AlterarSenhaScreenState();
}

class _AlterarSenhaScreenState extends State<AlterarSenhaScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _senhaAtualController = TextEditingController();
  final TextEditingController _novaSenhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alterar Senha'),
        backgroundColor: const Color(0xFFC54444),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo para senha atual
              TextFormField(
                controller: _senhaAtualController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha Atual',
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua senha atual';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Campo para nova senha
              TextFormField(
                controller: _novaSenhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Nova Senha',
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a nova senha';
                  }
                  if (value.length < 6) {
                    return 'A senha deve ter pelo menos 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Campo para confirmar nova senha
              TextFormField(
                controller: _confirmarSenhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirmar Nova Senha',
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, confirme a nova senha';
                  }
                  if (value != _novaSenhaController.text) {
                    return 'As senhas não coincidem';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // Botão para salvar as alterações
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Processar a alteração de senha
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Senha alterada com sucesso!')),
                    );
                    Navigator.pop(context); // Voltar para a tela anterior
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC54444),
                ),
                child: const Text('Alterar Senha'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
